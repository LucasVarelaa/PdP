% FUNCTORES Y POLIMORFISMO

% vende(Articulo,Precio)
% vende(Libro(Titulo,Autor,Genero,Editorial),Precio)
% vende(Cd(Titulo,Autor,Genero,CantDiscos,CantTemas),Precio)
% vende(Peli(Titulo,Director,Genero),Precio)
vende(libro(it,joni,terror,arboleda), 1000).
vende(libro(panda,raul,comedia,rocket), 1500).
vende(libro(mort,malena,suspenso,warner), 2000).
vende(cd(bloodOnTheTracks,pulp,pop,2,4), 500).
vende(peli(it,paul,terror),750).
vende(peli(leyend,mauro,suspenso),2000).

% POLIMORFISMO
% autor(Articulo,Autor)
autor(libro(_,Autor,_,_), Autor) :- vende(libro(_,Autor,_,_),_). %solo recursivo autor
autor(cd(_,Autor,_,_,_), Autor) :- vende(libro(_,Autor,_,_,_),_).


% 1: Se cumple para un articulo si es el libro de mayor precio
libroMasCaro(libro(Titulo,Autor,Genero,Editorial)) :-
    vende(libro(Titulo,Autor,Genero,Editorial),Precio),
    forall(vende(libro(_,_,_,_),OtroPrecio), OtroPrecio =< Precio).
/*
2 ?- libroMasCaro(libro(Titulo,Autor,Genero,Editorial)).
Titulo = mort,
Autor = malena,
Genero = suspenso,
Editorial = warner.

4 ?- libroMasCaro(libro(Titulo,_,_,_)).
Titulo = mort.
*/


% 2: Se cumple para un articulo si es lo unico que esta a la venta de ese autor
curiosidad(autor(Articulo,Autor)) :-
    vende(Articulo,_), % ya que Articulo no es recursivo en autor()
    autor(Articulo,Autor),
    not((vende(OtroArticulo,_), autor(OtroArticulo,Autor), Articulo \= OtroArticulo)).
/*
6 ?- curiosidad(autor(Articulo,Autor)). 
Articulo = libro(it, joni, terror, arboleda),
Autor = joni ; ... (y mas autores)
*/


% 3: Se cumple para un titulo si pertenece a mas de un articulo
sePrestaAConfusion(titulo(Articulo,Titulo)) :- 
    titulo(Articulo,Titulo),
    titulo(OtroArticulo,Titulo),
    Articulo \= OtroArticulo.

% titulo(Articulo,Titulo)
titulo(libro(Titulo,_,_,_),Titulo) :- vende(libro(Titulo,_,_,_),_).
titulo(cd(Titulo,_,_,_,_),Titulo) :- vende(cd(Titulo,_,_,_,_),_).
titulo(peli(Titulo,_,_),Titulo) :- vende(peli(Titulo,_,_),_).
/*
10 ?- sePrestaAConfusion(titulo(Articulo,Titulo)).
Articulo = libro(it, _, _, _),
Titulo = it ;
Articulo = peli(it, _, _),
Titulo = it ;
*/


% 4: se cumple para los autores de mas de un tipo de articulo
mixto(autor(Articulo,Autor)) :- autor(libro(_,_,_,_),Autor), autor(cd(_,_,_,_,_),Autor).
mixto(autor(Articulo,Autor)) :- autor(libro(_,_,_,_),Autor), autor(peli(_,_,_),Autor).
mixto(autor(Articulo,Autor)) :- autor(peli(_,_,_),Autor), autor(cd(_,_,_,_,_),Autor).

