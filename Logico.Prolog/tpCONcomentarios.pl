% Modelar lo necesario para representar los jugadores, las civilizaciones y las tecnologías, de la forma más conveniente para resolver los siguientes puntos. Incluir los siguientes ejemplos.
% Ana, que juega con los romanos y ya desarrolló las tecnologías de herrería, forja, emplumado y láminas.
% Beto, que juega con los incas y ya desarrolló herrería, forja y fundición.
% Carola, que juega con los romanos y sólo desarrolló herrería.
% Dimitri, que juega con los romanos y ya desarrolló herrería y fundición.
% Elsa no juega esta partida.

% jugador(Nombre, Civilizacion, Tecnologia)


jugador(ana,romanos,herreria).
jugador(ana,romanos,forja).
jugador(ana,romanos,emplumado).
jugador(ana,romanos,laminas).

jugador(beto,incas,herreria).
jugador(beto,incas,forja).
jugador(beto,incas,fundicion).

jugador(carola,romanos,herreria).

jugador(dimitri,romanos,herreria).
jugador(dimitri,romanos,fundicion).


% Saber si un jugador es experto en metales, que sucede cuando desarrolló las tecnologías de herrería, forja y o bien desarrolló fundición o bien juega con los romanos.
% En los ejemplos, Ana y Beto son expertos en metales, pero Carola y Dimitri no.

expertoMetales(Jugador):-
    jugador(Jugador,_,herreria),
    jugador(Jugador,_,forja),
    jugador(Jugador,_,fundicion).

expertoMetales(Jugador):-
    jugador(Jugador,_,herreria),
    jugador(Jugador,_,forja),
    jugador(Jugador,romanos,_).


%     Saber si una civilización es popular, que se cumple cuando la eligen varios jugadores (más de uno).
% En los ejemplos, los romanos es una civilización popular, pero los incas no.


civilizacionPopular(Civilizacion):-
    cantidadJugadores(Civilizacion,N),N>1.


civilizacion(romanos).
civilizacion(incas).


cantidadJugadores(Civilizacion,N):-
    civilizacion(Civilizacion),   % Generación: hacemos el predicado completamente inversible. La variable Civilizacion llega ligada al findall
    findall(X,distinct(X,jugador(X,Civilizacion,_)),Jugadores),
    length(Jugadores, N).
    

%     Saber si una tecnología tiene alcance global, que sucede cuando a nadie le falta desarrollarla.
% En los ejemplos, la herrería tiene alcance global, pues Ana, Beto, Carola y Dimitri la desarrollaron.

tecnologia(herreria).
tecnologia(forja).
tecnologia(fundicion).
tecnologia(emplumado).
tecnologia(laminas).


alcanceGlobal(Tecnologia):-
    noFaltaDesarrollar(Tecnologia).

noFaltaDesarrollar(Tecnologia):-
    tecnologia(Tecnologia), % Generación
    findall(X,distinct(X,jugador(X,_,Tecnologia)),JugadoresConTecnologia),
    findall(Y,distinct(Y,jugador(Y,_,_)),JugadoresTotales),
    length(JugadoresTotales,N1),
    length(JugadoresConTecnologia,N2),
    N1=N2.


    
%     Saber cuándo una civilización es líder. Se cumple cuando esa civilización alcanzó todas las tecnologías que alcanzaron las demás. (Una civilización alcanzó una tecnología cuando algún jugador de esa civilización la desarrolló).
% En los ejemplos, los romanos es una civilización líder pues entre Ana y Dimitri, que juegan con romanos, ya tienen todas las tecnologías que se alcanzaron.


civilizacionLider(Civilizacion):-
    alcanzoTecnologias(Civilizacion).


alcanzoTecnologias(Civilizacion):-
    civilizacion(Civilizacion), % Generación
    findall(alcanceGlobal(T),distinct(T,jugador(_,Civilizacion,T)),TecnologiasGlobalesMiCiv),
    findall(alcanceGlobal(T),distinct(T,jugador(_,X,T)),TecnologiasGlobalesGrales),
    length(TecnologiasGlobalesMiCiv,N1),
    length(TecnologiasGlobalesGrales,N2),
    N1=N2.


civilizacionLider(Civilizacion):-
    alcanzoTecnologias(Civilizacion).

alcanzoTecnologias(Civilizacion):-
    civilizacion(civilizacion),
    % Encuentra todas las tecnologías alcanzadas por cualquier civilización
    findall(Tecnologia, distinct(Tecnologia, jugador(_, _, Tecnologia)), TodasTecnologias),
    % Encuentra todas las tecnologías alcanzadas por la civilización en cuestión
    findall(Tecnologia, distinct(Tecnologia, jugador(_, Civilizacion, Tecnologia)), TecnologiasMiCiv),
    % Verifica que todas las tecnologías alcanzadas por cualquier civilización están en las tecnologías de la civilización en cuestión
    %subset(TodasTecnologias, TecnologiasMiCiv).
    length(TecnologiasMiCiv,N1),
    length(TodasTecnologias,N2),
    N1=N2.

% subset/2 verifica que todos los elementos del primer conjunto están en el segundo conjunto