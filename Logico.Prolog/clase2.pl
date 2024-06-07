% ---- HECHOS ------
% habitat(Animal,Habitat)
habitat(jirafa,sabana).
habitat(elefante,sabana).
habitat(elefante,selva).
habitat(tiburon,mar).

animal(jirafa).

% templado(Bioma)
templado(selva).
templado(costa).

%----------------------

% acuatico(Animal)
acuatico(Animal) :- habitat(Animal,mar).

% terrestre(Animal)
terrestre(Animal) :- animal(Animal), % es necesario porque not, es de orden superior y no son recursivas
                     not(habitat(Animal,mar)).
                    %not(acuatico(Animal)).

% friolento(Animal)
friolento(Animal) :- 
    animal(Animal), % como el not, forall es de orden superior y es necesario hacer esto para cuando quiero pedir todos los animales friolentos -- friolento(Animal).
    forall(habitat(Animal,Bioma), templado(Bioma)).

% not(p(x)) -- niega el resultado de la expresion dada -- SOLO UNA SENTENCIA 
% forall(Universo,Condicion) -- es como un paraTodo
%       (x=...   , true/false)
% si para todo x cumple p es equivalente a decir no existe x que no cumpla con p

/*
forall(animal(X),friolento(X)) -> not((animal(X),not(friolento(X))))
todos los animales son friolentos = no existe animal que no sea friolento

not(forall(animal(X),friolentos(X))) -> animal(X),not(friolento(X))
no todos los animales son friolentos = existen animales que no son friolentos

forall(animal(X),not(friolento(X))) -> not((animal(X),friolento(X)))
ningun animal es friolento = no existen animales friolentos
*/


% PRACTICA 

% come(Depredador,Presa)
come(orca,foca).

%1: relaciona un animal con un bioma si todos los animales que lo habitan se los comen.
hostil(Animal,Bioma) :- 
    animal(Animal), habitat(_,Bioma), % Por lo que entiendo se usan las variables que declaro al principio... hostil(...,...) y desp las uso en un ord sup
    forall(habitat(OtroAnimal,Bioma),come(OtroAnimal,Animal)).

%2: relaciona un animal on un bioma si todos los animales que se los comen habitan en su bioma
terrible(Animal,Bioma) :- 
    animal(Animal), habitat(_,Bioma),
    forall(come(OtroAnimal,Animal),habitat(OtroAnimal,Bioma)).

%3: relaciona 2 animales si ninguno de los dos come al otro
conpatibles(UnAnimal,OtroAnimal) :-
    animal(UnAnimal), animal(Otroanimal),
    not(come(UnAnimal,OtroAnimal)),
    not(come(OtroAnimal,UnAnimal)).

%4: se cumple para los animales que habitan todos los biomas
adaptable(Animal) :- 
    animal(Animal),
    forall(habitat(_,Bioma),habitat(Animal,Bioma)).
% pregunta si el animal habita todos los biomas

%5: se cumple para los animales que SOLO habitan en 1 bioma 
raro(Animal) :-
    % animal(Animal), habitat(_,Bioma), -- EN ESTE CASP NO HACE FALTA PORQUE habitat(Animal,Bioma) ya es inversible
    habitat(Animal,Bioma),
    not((habitat(Animal,OtroBioma), Bioma \= OtroBioma)).
% Un animal habita un bioma y no hay otro habitat que habite

%6: se cumple para los animales que se comen a todos los animales de su habitat
dominante(Animal) :-
    habitat(Animal,Bioma),
    forall((habitat(OtroAnimal,Bioma), Otro \= Animal), come(Animal,Otro)).