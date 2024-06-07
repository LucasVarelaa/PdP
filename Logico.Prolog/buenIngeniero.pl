% Buen ingeniero - tiene titulo, resolver problemas, tener plata, saber idiomas importantes
% discipulo (A,B) -- disciplina, edad <, B experiencia
% a partir de relaciones padre e hijo, deducir parentezco hijo, abuelo.

tieneTitulo(raul, ingeniero).
tieneTitulo(jose, profesor).
tieneTitulo(robert, ingeniero).

resuelve(raul).
resuelve(lola).
resuelve(ricardo).

tienePlata(raul).
tienePlata(horacio).
tienePlata(herenesto).

fondos(raul, 1000, canin).

sabeIdiomas(raul, ingles).
sabeIdiomas(horacio, espaniol).
sabeIdiomas(robert, italiano).

manejaIdioma(Ingeniero) :-
    sabeIdiomas(Ingeniero, ingles).


buenIngeniero(Ingeniero) :- 
    tieneTitulo(Ingeniero, ingeniero),
    resuelve(Ingeniero),
    fondos(Ingeniero, Fondos, _), Fondos > 900,
    manejaIdioma(Ingeniero).

%------------DISCIPULO--------------------------------------

/*
tieneDisciplina(juan).
tieneDisciplina(raul).
tieneDisciplina(jose).

edad()
esMayor(A,B) :- edad(A) > edad(B)

discipulo(A,B) :-
    tieneDisciplina(A),
    esMayor(A),
    tieneExperiencia(A).
*/