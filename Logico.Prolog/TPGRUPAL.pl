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

% Primera entrega

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

expertoenMetales(Jugador):- 
    desarrolla(Jugador,herreria),
    desarrolla(Jugador,forja),
    desarrolla(Jugador,fundicion).
expertoenMetales(Jugador):- 
    desarrolla(Jugador,herreria),
    desarrolla(Jugador,forja),
    juega(Jugador,romanos).


% 3) --------------------------------------------------------------------------------------------------------------------------------------
civilizacion_popular(Civilizacion):-
    juega(J1,Civilizacion),
    juega(J2,Civilizacion),
    J1\=J2.

% 4)-------------------------------------------------------------------------------------------------------------
alcanceglobal(Tecnologia) :-
    tecnologia(Tecnologia),
    forall(jugador(Jugador),desarrolla(Jugador,Tecnologia)).

% 5)-----------------------------------------------------------------------------------------------------------
civilizacionLider(Civilizacion) :-
    civilizacion(Civilizacion),
    forall(tecnologia(Tecnologia), (juega(Jugador,Civilizacion),desarrolla(Jugador,Tecnologia))).


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

unidadConMasVida(Jugador,Unidad):-
    jugador(Jugador),
    unidad(Jugador,Unidad,_),
    forall((unidad(Jugador,Unidad,Vida),unidad(Jugador,U2,V2),Unidad\=U2),Vida > V2).


% 8) --------------------------------------------------

leGana1(U1,U2):-
    U1 = jinete(_),
    U2 = campeon(_).

pierde1(U2,U1):-leGana1(U1,U2).


leGana2(U1,U2):-
    U1= campeon(_),
    U2= piqueroConEscudo(_).

pierde2(U2,U1):-leGana2(U1,U2).

leGana3(U1,U2):-
    U1= campeon(_),
    U2= piqueroSinEscudo(_).
pierde3(U2,U1):-leGana3(U1,U2).

leGana4(U1,U2):-
    U1=piqueroSinEscudo(_),
    U2=jinete(_).
pierde4(U2,U1):-leGana4(U1,U2).

leGana5(U1,U2):-
    U1=piqueroConEscudo(_),
    U2=jinete(_).

pierde5(U2,U1):-leGana5(U1,U2).

leGana6(U1,U2):-
    U1=jinete(camello),
    U2=jinete(caballo).

pierde6(U2,U1):-leGana6(U1,U2).

leGanaConVida(V1,V2):-
    V1 > V2.



leGanaConVentaja(U1,U2):-leGana1(U1,U2).
leGanaConVentaja(U1,U2):-leGana2(U1,U2).
leGanaConVentaja(U1,U2):-leGana3(U1,U2).
leGanaConVentaja(U1,U2):-leGana4(U1,U2).
leGanaConVentaja(U1,U2):-leGana5(U1,U2).
leGanaConVentaja(U1,U2):-leGana6(U1,U2).

pierdeConVentaja(U2,U1):-pierde1(U1,U2).
pierdeConVentaja(U2,U1):-pierde2(U1,U2).
pierdeConVentaja(U2,U1):-pierde3(U1,U2).
pierdeConVentaja(U2,U1):-pierde4(U1,U2).
pierdeConVentaja(U2,U1):-pierde5(U1,U2).
pierdeConVentaja(U2,U1):-pierde6(U1,U2).

% Regla pedida (leGana) :

leGana(U1,U2):-
    unidad(_,U1,V1),
    unidad(_,U2,V2),
    U1\=U2,
    leGanaConVentaja(U1,U2).


leGana(U1,U2):-
    unidad(_,U1,V1),
    unidad(_,U2,V2),
    U1\=U2,
    not(leGanaConVentaja(U1,U2)),
    not(pierdeConVentaja(U2,U1)),
    leGanaConVida(V1,V2).


% 9) --------------------------------------------------


sobreviveAsedio(Jugador) :-
    jugador(Jugador),
    findall(piqueroConEscudo(Nivel), unidad(Jugador, piqueroConEscudo(Nivel), _), ListaConEscudo),
    findall(piqueroSinEscudo(Nivel), unidad(Jugador, piqueroSinEscudo(Nivel), _), ListaSinEscudo),
    length(ListaConEscudo, Cant1),
    length(ListaSinEscudo, Cant2),
    Cant1 > Cant2.
    


% 10) -------------------------------------------------

% a) 

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

% b) -----------------------------------------

puede(Jugador,Tecnologia):-
    jugador(Jugador),
    tecnologia(Tecnologia),
    not(desarrolla(Jugador,Tecnologia)),
    Tecnologia = molino.


puede(Jugador,Tecnologia):-
    jugador(Jugador),
    tecnologia(Tecnologia),
    not(desarrolla(Jugador,Tecnologia)),
    Tecnologia = herreria.


puede(Jugador,Tecnologia):-
    jugador(Jugador),
    tecnologia(Tecnologia),
    not(desarrolla(Jugador,Tecnologia)),
    antecedente(Tecnologia,Res),
    desarrolla(Jugador,Res).
