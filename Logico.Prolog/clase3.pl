%  https://docs.google.com/document/d/157fVu--q-qQ3ANgypi9fErT_JqBJxAd8NfosblNjag0/edit#heading=h.2djr91u45erj

% Se cumple para los jugadores.
jugador(Jugador).
% Ejemplo:
% jugador(rojo).

% Relaciona un país con el continente en el que está ubicado,
ubicadoEn(Pais, Continente).
% Ejemplo:
% ubicadoEn(argentina, américaDelSur).

% Relaciona dos jugadores si son aliados.
aliados(Jugador1, Jugador2).
% Ejemplo:
% aliados(rojo, amarillo).

% Relaciona un jugador con un país en el que tiene ejércitos.
ocupa(Jugador, Pais).
% Ejemplo:
% ocupa(rojo, argentina).

% Relaciona dos países si son limítrofes.
limitrofes(Pais1, Pais2).
% Ejemplo:
% limítrofes(argentina, brasil).

% Se pide modelar los siguientes predicados, de forma tal que sean completamente inversibles:

% 1) tienePresenciaEn/2: 
% Relaciona un jugador con un continente del cual ocupa, al menos, un país.

tienePresenciaEn(Jugador,Continente) :-
    ocupa(Jugador,Pais),
    ubicadoEn(Pais,Continente).

% 2) puedenAtacarse/2: 
% Relaciona dos jugadores si uno ocupa al menos un país limítrofe a algún país ocupado por el otro.

puedenAtacarse(Jugador1,Jugador2) :-
    ocupa(Jugador1, Pais1),
    ocupa(Jugador2, Pais2),
    limitrofes(Pais1, Pais2).

% 3) sinTensiones/2: 
% Relaciona dos jugadores que, o bien no pueden atacarse, o son aliados.

sinTensiones(Jugador1,Jugador2) :- aliados(Jugador1,Jugador2).

sinTensiones(Jugador1,Jugador2) :- 
    jugador(Jugador1), jugador(Jugador2),
    not(puedenAtacarse(Jugador1,Jugador2)).

% 4) perdió/1: 
% Se cumple para un jugador que no ocupa ningún país.

perdio(Jugador) :- 
    jugador(Jugador),
    not(ocupa(Jugador,Pais)).

% 5) controla/2: 
% Relaciona un jugador con un continente si ocupa todos los países del mismo.

controla(Jugador,Continente) :- 
    jugador(Jugador), ubicadoEn(_,Continente).
    forall(ubicadoEn(Pais,Continente), ocupa(Jugador,Pais)).

controla2(Jugador,Continente) :- 
    jugador(Jugador), ubicadoEn(_,Continente).
    not((ubicadoEn(Pais,Continente), not(ocupa(Jugador,Pais)))).

% 6) reñido/1: 
%Se cumple para los continentes donde todos los jugadores ocupan algún país.

renido(Continente) :-
    ubicadoEn(_,Continente),
    forall(jugador(Jugador),(ocupa(Jugador,Pais),ubicadoEn(Pais,Continente))).
%                          , tienePresenciaEn(Jugador,Continente).

renido2(Continente) :-
    ubicadoEn(_,Continente),
    not((jugador(Jugador),not(ocupa(Jugador,Pais),ubicadoEn(Pais,Continente)))).

renido3(Continente) :-
    ubicadoEn(_, Continente),
    findall(Jugador, (jugador(Jugador), ocupa(Jugador, Pais), ubicadoEn(Pais, Continente)), Jugadores),
    length(Jugadores, CantJugadores),
    jugador(JugadorTotal),
    length(JugadoresTotales, CantTotal),
    CantJugadores =:= CantTotal.

% 7) atrincherado/1: 
% Se cumple para los jugadores que ocupan países en un único continente.

atrincherado(Jugador) :-
    jugador(Jugador),ubicadoEn(_,Continente), %necesito declarar continente sino no tendria relacion con el jugador
    forall(ocupa(Jugador,Pais),ubicadoEn(Pais,Continente)).


% 8) puedeConquistar/2: 
% Relaciona un jugador con un continente si no lo controla, pero todos los países del continente que 
% le falta ocupar son limítrofes a alguno que sí ocupa y pertenecen a alguien que no es su aliado.

puedeConquistar(Jugador,Continente) :-
    jugador(Jugador),ubicadoEn(_,Continente),
    not(controla(Jugador,Continente)),
    forall((ubicadoEn(Pais,Continente),not(ocupa(Jugador,Pais))), pudeAtacar(Jugador,Pais)).
%   forall(Condicion,Accion).
% condicion = pais del continente que no tiene
% accion = puede atacar 

%el pais es limitrofe a alguno que el jugador ocupa y pertenece a alguien que no es su aliado
puedeAtacar(Jugador,PaisAtacado) :-
    ocupa(Jugador,PaisAtacado),
    limitrofes(Jugador,PaisAtacado),
    not((aliados(Jugador,Aliado),ocupa(Aliado,PaisAtacado))).


/*
forall(Condición, Acción)
Condición: un predicado que debe ser verdadero.
Acción: un predicado que debe cumplirse para cada caso que satisface la condición.
ej: forall(member(X, [1, 2, 3]), X > 0).
Esto verifica que todos los elementos de la lista [1, 2, 3] son mayores que 0.

not(Condición)
not(member(4, [1, 2, 3])).
Esto verifica que 4 no es un miembro de la lista [1, 2, 3].

member(Elemento, Lista)
Elemento: El elemento que se verifica o se genera.
Lista: La lista en la cual se verifica la pertenencia o de la cual se generan elementos.

findall(Variable, Consulta, Lista): Aquí, Variable es la variable que queremos encontrar, 
Consulta es la consulta que queremos resolver y Lista es la lista en la que se almacenarán todas las soluciones encontradas.
 
*/
