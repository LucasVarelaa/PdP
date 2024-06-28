/*Entre los juegos de simulación de civilizaciones históricas y batallas hay uno que se destaca: 
El Eish. Es un juego en el que cada jugador escoge una civilización antigua y va desarrollando tecnologías y creando sus unidades. 
Se pide la codificación en SWI-Prolog, constando de una base de conocimientos con los predicados necesarios para obtener lo que se indica a continuación. 
Todos los predicados principales deben ser completamente inversibles.
Civilizaciones y tecnologías
1)  Modelar lo necesario para representar los jugadores, las civilizaciones y las tecnologías, de la forma más conveniente para resolver los siguientes puntos. 
Incluir los siguientes ejemplos.
a-  Ana, que juega con los romanos y ya desarrolló las tecnologías de herrería, forja, emplumado y láminas.

b-  Beto, que juega con los incas y ya desarrolló herrería, forja y fundición.

c-  Carola, que juega con los romanos y sólo desarrolló herrería.

d-  Dimitri, que juega con los romanos y ya desarrolló herrería y fundición.

e-  Elsa no juega esta partida.
2)  Saber si un jugador es experto en metales, que sucede cuando desarrolló las tecnologías de herrería, forja y o bien desarrolló fundición o bien juega con los romanos.
En los ejemplos, Ana y Beto son expertos en metales, pero Carola y Dimitri no.

3)  Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).
En los ejemplos, los romanos es una civilización popular, pero los incas no.

4)  Saber si una tecnología tiene alcance global, que sucede cuando a nadie le falta desarrollarla.
En los ejemplos, la herrería tiene alcance global, pues Ana, Beto, Carola y Dimitri la desarrollaron.

5)  Saber cuándo una civilización es líder. Se cumple cuando esa civilización alcanzó todas las tecnologías que alcanzaron las demás. 
(Una civilización alcanzó una tecnología cuando algún jugador de esa civilización la desarrolló).
En los ejemplos, los romanos es una civilización líder pues entre Ana y Dimitri, que juegan con romanos, ya tienen todas las tecnologías que se alcanzaron.
*/

% 1)
%      (Jugador)
jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).

%           (Civilizacion)
civilizacion(inca).
civilizacion(romanos).

%         (Tecnologia)
tecnologia(herreria).
tecnologia(molino).
tecnologia(emplumado).
tecnologia(forja).
tecnologia(laminado).
tecnologia(collera).
tecnologia(punzon).
tecnologia(fundicion).
tecnologia(malla).
tecnologia(arado).
tecnologia(horno).
tecnologia(placas).

%    (Jugador, Cvilizacion)
juega(ana, romanos).
juega(beto, incas).
juega(carola, romanos).
juega(dimitri, romanos).

%         (Jugador, Tecnologia)
desarrolla(ana, herreria).
desarrolla(ana, forja).
desarrolla(ana, emplumado).
desarrolla(ana, laminado).
desarrolla(beto, herreria).
desarrolla(beto, forja).
desarrolla(beto, fundicion).
desarrolla(carola, herreria).
desarrolla(dimitri, herreria).
desarrolla(dimitri, fundicion).

% 2)-----------------------------------------------------------------------------------------------------------------------------------------

expertoEnMetales(Jugador):- 
    desarrolla(Jugador,herreria),
    desarrolla(Jugador,forja),
    desarrolla(Jugador,fundicion).
expertoEnMetales(Jugador):- 
    desarrolla(Jugador,herreria),
    desarrolla(Jugador,forja),
    juega(Jugador,romanos).

% 3) --------------------------------------------------------------------------------------------------------------------------------------

civilizacionPopular(Civilizacion) :-
    juega(Jugador1, Civilizacion),
    juega(Jugador2, Civilizacion),
    Jugador1 \= Jugador2.

% 4)-------------------------------------------------------------------------------------------------------------

alcanceGlobal(Tecnologia) :-
    tecnologia(Tecnologia),
    forall(jugador(Jugador),desarrolla(Jugador,Tecnologia)).
  
% 5)-----------------------------------------------------------------------------------------------------------
    
civilizacionLider(Civilizacion) :-
    civilizacion(Civilizacion),
    forall(tecnologia(Tecnologia),(juega(Jugador,Civilizacion),desarrolla(Jugador,Tecnologia))).

% --------------------------------------------------------------------------------------------------------------

% Segunda entrega

% 6) --------------------------------------------------

rangoVidaValido(Vida):-
    between(1,100,Vida).


campeon(Vida):-
    rangoVidaValido(Vida).

jinete(Animal):-
    Animal = camello.

jinete(Animal):-
    Animal = caballo.

piqueroConEscudo(Nivel):-
    between(1,3,Nivel).

piqueroSinEscudo(Nivel):-
    between(1,3,Nivel).
    
unidad(ana,jinete(caballo),90).
unidad(ana,piqueroConEscudo(1),55). % 50 * 1.1
unidad(ana,piqueroSinEscudo(2),65).

unidad(beto,campeon(100),100).
unidad(beto,campeon(80),80).
unidad(beto,piqueroConEscudo(1),55).
unidad(beto,jinete(camello),80).

unidad(carola,piqueroSinEscudo(3),70).
unidad(carola,piqueroConEscudo(2),72). % 65*1.1 = 71.5, redondeo para arriba

% 7) --------------------------------------------------

unidadConMasVida(Jugador, Unidad) :-
    jugador(Jugador),
    unidad(Jugador, Unidad, Vida),
    forall((unidad(Jugador, OtraUnidad, OtraVida), Unidad \= OtraUnidad), Vida > OtraVida).
/*
7 ?- unidadConMasVida(ana,Unidad).
Unidad = jinete(caballo)
*/

% 8) --------------------------------------------------

% Definición de las ventajas de tipo de unidad
leGanaPorTipo(jinete(_), campeon(_)).
leGanaPorTipo(campeon(_), piqueroSinEscudo(_)).
leGanaPorTipo(campeon(_), piqueroConEscudo(_)).
leGanaPorTipo(piqueroSinEscudo(_), jinete(_)).
leGanaPorTipo(piqueroConEscudo(_), jinete(_)).
leGanaPorTipo(jinete(camello), jinete(caballo)).

% Verificar ventaja por tipo de unidad
leGana(U1, U2) :-
    leGanaPorTipo(U1, U2).

% Si no hay ventaja por tipo, comparar por vida
leGana(U1, U2) :-
    unidad(_, U1, V1),
    unidad(_, U2, V2),
    not(leGanaPorTipo(U1, U2)),
    not(leGanaPorTipo(U2, U1)),
    V1 > V2.

% 9) --------------------------------------------------


sobreviveAsedio(Jugador) :-
    jugador(Jugador),
    findall(piqueroConEscudo(Nivel), unidad(Jugador, piqueroConEscudo(Nivel), _), ListaConEscudo),
    findall(piqueroSinEscudo(Nivel), unidad(Jugador, piqueroSinEscudo(Nivel), _), ListaSinEscudo),
    length(ListaConEscudo, Cant1),
    length(ListaSinEscudo, Cant2),
    Cant1 > Cant2.

% 9) -------------------------------------------------

%         (dependiente, dependencia)
antecedente(collera,molino).
antecedente(emplumado,herreria).
antecedente(forja,herreria).
antecedente(laminado,herreria).

antecedente(arado,collera).
antecedente(punzon,emplumado).
antecedente(fundicion,forja).
antecedente(malla,laminado).

antecedente(horno,fundicion).
antecedente(placas,malla).

% Verificar si se pueden desarrollar tecnologías (revisando dependencias)
puede(Jugador, Tecnologia) :-
    tecnologia(Tecnologia),
    not(desarrolla(Jugador, Tecnologia)),
    puedeDesarrollar(Jugador, Tecnologia).

puedeDesarrollar(Jugador, Tecnologia) :-
    not(antecedente(Tecnologia, _)). % Tecnología sin dependencias
% Si no existe ninguna dependencia para Tecnologia (not(antecedente(Tecnologia, _))),
% entonces Tecnologia se puede desarrollar directamente.

puedeDesarrollar(Jugador, Tecnologia) :-
    antecedente(Tecnologia, Dependencia),
    desarrolla(Jugador, Dependencia).
% Si Tecnologia tiene una dependencia (antecedente(Tecnologia, Dependencia)) y el jugador ya 
% ha desarrollado esta dependencia (desarrolla(Jugador, Dependencia)), entonces el jugador 
% puede desarrollar Tecnologia.

puedeDesarrollar(Jugador, Tecnologia) :-
    antecedente(Tecnologia, Dependencia),
    puedeDesarrollar(Jugador, Dependencia).
% verifica que tenga todas sus dependencias (desde el actual hasta su dependencia de la dependencia y asi)