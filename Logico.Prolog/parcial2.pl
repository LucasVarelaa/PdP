% Personas
%persona(Persona,Edad,Altura)
persona(nina, 22, 1.60).
persona(marcos, 8, 1.32).
persona(osvaldo, 13, 1.29).
personas(nina,marcos,osvaldo).

% Atracciones en Parque de la Costa
%atraccion(Parque,Atraccion,Edad,Altura)
atraccion(parqueDeLaCosta, trenFantasma, edad(12), ninguna).
atraccion(parqueDeLaCosta, montaniaRusa, ninguna, altura(1.30)).
atraccion(parqueDeLaCosta, maquinaTiquetera, ninguna, ninguna).


% Atracciones en Parque Acuatico
%atraccion(Parque,Atraccion,Edad,Altura)
atraccion(parqueAcuatico, toboganGigante, ninguna, altura(1.50)).
atraccion(parqueAcuatico, rioLento, ninguna, ninguna).
atraccion(parqueAcuatico, piscinaDeOlas, edad(5), ninguna).


% Pasaportes
%pasaporte(Persona,Pasaporte)
pasaporte(nina, basico(20)).
pasaporte(marcos, flex(10, toboganGigante)).
pasaporte(osvaldo, premium).

% Juegos y sus costos en créditos
%juegoCosto(Juego, Costo)
juegoCosto(trenFantasma, 5).
juegoCosto(montaniaRusa, 10).
juegoCosto(maquinaTiquetera, 2).
juegoCosto(toboganGigante, 7).
juegoCosto(rioLento, 4).
juegoCosto(piscinaDeOlas, 3).

% Juegos premium
juegoPremium(toboganGigante).

% REQUERIMIENTOS
% Modelar la base de conocimiento para contener esa información, 
% proveyendo ejemplos, y programar los siguientes predicados:

% Puede subir a la atracción si cumple con la edad y altura mínima
puedeSubir(Persona, Atraccion) :-
    persona(Persona, Edad, Altura),
    atraccion(_, Atraccion, RequisitoEdad, RequisitoAltura),
    cumpleRequisito(RequisitoEdad, Edad),
    cumpleRequisito(RequisitoAltura, Altura),
    puedeUsarPasaporte(Persona, Atraccion).

cumpleRequisito(ninguna, _).
cumpleRequisito(edad(MinEdad), Edad) :- Edad >= MinEdad.
cumpleRequisito(altura(MinAltura), Altura) :- Altura >= MinAltura.

puedeUsarPasaporte(Persona, Atraccion) :-
    pasaporte(Persona, basico(Creditos)),
    juegoCosto(Atraccion, Costo),
    Creditos >= Costo,
    not(juegoPremium(Atraccion)).

puedeUsarPasaporte(Persona, Atraccion) :-
    pasaporte(Persona, flex(Creditos, Premium)),
    juegoCosto(Atraccion, Costo),
    Creditos >= Costo.
puedeUsarPasaporte(Persona, Atraccion) :-
    pasaporte(Persona, flex(Creditos, Premium)),
    juegoCosto(Atraccion, Costo),
    Atraccion = Premium.

puedeUsarPasaporte(Persona, Atraccion) :-
    pasaporte(Persona, premium).

% Es para Elle si puede subir a todas las atracciones del parque
esParaElle(Parque, Persona) :-
    persona(Persona,_,_),
    atraccion(Parque, _, _, _),
    forall(atraccion(Parque, Atraccion, _, _), puedeSubir(Persona, Atraccion)).

% Mala idea si no hay ninguna atracción a la que todos puedan subir
malaIdea(Personas, Parque) :-
    atraccion(Parque, _, _, _),
    not(existeAtraccionComún(Personas, Parque)).

existeAtraccionComún(Personas, Parque) :-
    atraccion(Parque, Atraccion, _, _),
    forall(member(Persona, Personas), puedeSubir(Persona, Atraccion)).

% Programa lógico si todas las atracciones están en el mismo parque y no se repiten
programaLogico([A1|As]) :-
    atraccion(Parque, A1, _, _),
    programaLogicoAux(Parque, As).

programaLogicoAux(_, []).
programaLogicoAux(Parque, [A|As]) :-
    atraccion(Parque, A, _, _),
    not(member(A, As)),
    programaLogicoAux(Parque, As).
/*
28 ?- programaLogico([trenFantasma,montaniaRusa]).
true .

29 ?- programaLogico([trenFantasma,piscinaDeOlas]).
false.

33 ?- programaLogico([trenFantasma,montaniaRusa,maquinaTiquetera, maquinaTiquetera]).
false.
*/

% Subprograma hasta la primera atracción a la que no puede subir
hastaAca(_, [], []).
hastaAca(Persona, [A|As], [A|Subprograma]) :-
    puedeSubir(Persona, A),
    hastaAca(Persona, As, Subprograma).
hastaAca(Persona, [A|_], []) :-
    not(puedeSubir(Persona, A)).

/*
44 ?- hastaAca(nina,[trenFantasma,montaniaRusa,maquinaTiquetera,toboganGigante,rioLento,piscinaDeOlas],A).
A = [trenFantasma, montaniaRusa, maquinaTiquetera]
*/