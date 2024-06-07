% padre(Padre,Hijo)
padre(abraham,homero).
padre(homero,bart).
padre(homero,lisa).
padre(bart,raul).
padre(raul,robert).

% abuelo(Abuelo,Nieto)
abuelo(Abuelo,Nieto) :-
    padre(Abuelo,Padre),
    padre(Padre,Nieto).

/*    
    abuelo(abraham,bart).
    true.
    
    abuelo(homero,bart).
    false.

*/

% hermano(Uno,Otro)
hermano(Uno,Otro) :-
    padre(Padre,Uno),
    padre(Padre,Otro),
    Uno \= Otro.

/*
    hermano(bart,lisa).
    true.
    
    hermano(lisa,bart).
    true.
    
    hermano(lisa,lisa).
    false.
*/

% ancestro(Ancestro,Descediente) -- USO RECURSIVIDAD
ancestro(Ancestro,Descediente) :- padre(Ancestro,Descediente).
ancestro(Ancestro,Descediente) :-
    padre(Ancestro,Alguien),
    ancestro(Alguien,Descediente).
/*
    ancestro(homero,bart).
    true .

    ancestro(abraham,robert).
    true .

    ancestro(homero,raul).
    true .
*/