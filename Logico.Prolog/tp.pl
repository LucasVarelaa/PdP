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
jugador(ana).
jugador(beto).
jugador(carola).
jugador(dimitri).

civilizacion(inca).
civilizacion(romanos).

tecnologia(herreria).
tecnologia(forja).
tecnologia(emplumado).
tecnologia(laminado).
tecnologia(fundicion).
juega(ana, romanos).
juega(beto, incas).
juega(carola, romanos).
juega(dimitri, romanos).

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
    findall(Jugador,juega(Jugador,Civilizacion),Jugadores),
    length(Jugadores,Cant),
    civilizacion(Civilizacion),
    Cant>1.

% 4)-------------------------------------------------------------------------------------------------------------
alcanceglobal(Tecnologia) :-
    tecnologia(Tecnologia),
    findall(Jugador, (desarrolla(Jugador, Tecnologia),jugador(Jugador)), Jugadores),
    findall(Jugador2,(jugador(Jugador2)),ListaJugadores),
    length(Jugadores,Cant1),
    length(ListaJugadores,Cant2),
    Cant1=:=Cant2.
%=:=: Este operador se utiliza para comparar dos expresiones aritméticas y verificar si son iguales. 
% Si las expresiones son iguales, devuelve true; de lo contrario, devuelve false.

%findall(Variable, Consulta, Lista): Aquí, Variable es la variable que queremos encontrar, 
%Consulta es la consulta que queremos resolver y Lista es la lista en la que se almacenarán todas las soluciones encontradas.
   
% 5)-----------------------------------------------------------------------------------------------------------
    alcanzoTecnologias(Civilizacion):-
        civilizacion(Civilizacion), % Generación
        findall(Tecnologia,distinct(Tecnologia,(juega(_,Civilizacion),desarrolla(_,Tecnologia))),TecnologiasCivilizacion),
        findall(Tecnologia,distinct(Tecnologia,(juega(_,X),desarrolla(_,Tecnologia))),TodasTecnologias),
        length(TecnologiasCivilizacion,N1),
        length(TodasTecnologias,N2),
        N1=N2.

 alcanzada(Civilizacion, Tecnologia) :-
     juega(Jugador, Civilizacion),
     desarrolla(Jugador, Tecnologia).