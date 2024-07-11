%LISTAS
/*
[] vacio
[cabeza | cola]
[1,2,3] = [1| [2 |[3 | []]]]
[queso(brise),2,3] podes trabajar con distintos tipos
*/
member(Elemento, Lista).
%podes consultar: member(pasto, LISTA). para ver si esta en esa lista.
%otro ejemplo. member(Elemento, LISTA). para que te de los elementos.

length(Lista, Tamanio).
%length([piedra,papel,tijera], 3). TRUE
%length([piedra,papel,tijera], Tamanio). tamanio = 3

sumlist(Lista, Total).
%sumlist([1,2,3], 6). True
%sumlist([1,2,3], Sumatoria). Sumatoria = 6

findall(Selector, Consulta, Lista).
% Selector: Sirve para elegir que porcion de la consulta quiero generar (que cosa quiero)
% Consulta: sirve para que se haga y se obtenga respuestas (genera posibles valores)
% Lista: donde se agarran los elementos
% Sirve para crear una lista
% se usa para agrupar respuestas a consultas, solo cuando necesitamos pensar todas las respuestas al mismo tiempo

%-----------------------------------------------------------------------------
%receta(Nombre, Ingredientes)

%receta(caramelo, ingrediente(agua,100)).
%receta(caramelo, ingrediente(azucar,100)).

% CON LISTAS
%               Ingrediente: [ingrediente(Nombre, Cantidad)]
%receta(caramelo, [ingrediente(agua, 100), ingrediente(azucar, 300)]).

%rapida(Receta) tiene menos de 4 ingredientes
rapida(Receta) :-
    receta(Receta,Ingredientes),
    length(Ingredientes, Total),
    Total < 4.

%postre(Receta) tiene mas de 250 de azucar
postre(Receta) :-
    receta(Receta,Ingredientes),
    member(ingrediente(azucar,Cantidad), Ingredientes),
    Cantidad > 250.

findall(Nombre, receta(Nombre,Ingredientes), Recetas).
% crea una lista(Recetas) de NOMBRES de las recetas que se encuentran en la lista

findall(Nombre, (receta(Nombre, _ ),rapida(Nombre)),Recetas).

findall(dulce(Nombre), postre(Nombre), Dulces).
% ENCONTRA TODOS LOS POSTRES, QUEDATE CON EL NOMBRE PERO EN DULCE Y DAME UNA LISTA LLAMADA DULCES


%cantidadDePostes(Cantidad) se cumple para el numero de recetas de postre en la base
cantidadDePostes(Cantidad) :-
    findall(1, postre(Receta), Postres),
    sumlist(Postres, Cantidad).
%Por cada postre se hace un elemento con valor 1 en la lista y luego se suman.
% El findall se puede usar como un filter o un map.
% La mayor cantidad de poblemas se resuelven SIN LISTAS
% solo si necesitamos pensar en todos los elementos a la vez o cuando lo pidan


%------------------------PRACTICA-------------------------------------
%receta(Nombre, Ingredientes)
receta(caramelo, [ingrediente(agua, 100), ingrediente(azucar, 50)]).
receta(ensalada, [ingrediente(lechuga, 100), ingrediente(pollo, 50), ingrediente(pepilo, 20)]).
receta(tortaFrita, [ingrediente(arina, 200), ingrediente(azucar, 500)]).
receta(bifeAhumado, [ingrediente(carne, 400)]).
receta(churro, [ingrediente(dulceDeLeche, 20)]).

ingrediente(Ingrediente).
ingrediente(arina).
ingrediente(carne).
calorias(Ingrediente,Calorias).
calorias(arina,200).
calorias(carne,80).

% 1) trivial: Se cumple para las recetas con un unico ingrediente.
%trivial(Receta)
trivial(Nombre) :-
    receta(Nombre,Ingredientes),
    length(Ingredientes, 1).
%trivial(Nombre) :- receta(Receta,[_]). % es lo mismo que arriba

% 2) elPeor: Relaciona una receta con su ingrediente mas calorico.
%elPeor(Ingredientes,Peor)
elPeor(Ingredientes,Peor) :-
    member(Peor, Ingredientes), calorias(Peor,CaloriasDelPeor),
    forall(
        member(Ingrediente,Ingredientes),
        (calorias(Ingrediente, Calorias), CaloriasDelPeor >= Calorias)
    ).
%Para toda caloria de ingrediente, CaloriasDelPor >= que la caloria de cada ingrediente

% 3) caloriasTotales: Relaciona una receta y su total de calorias.
caloriasTotales(Receta,Total) :-
    receta(Receta,Ingredientes),
    findall(Kcal, (member(Ing,Ingredientes), calorias(Ing, Kcal)), Kcals),
    sumlist(Kcals, Total).

% 4) versionLight: Relaciona una receta con sus ingredientes, sin el peor.
versionLight(Receta,IngredientesLight) :-
    receta(Receta,Ingredientes),
    elPeor(Ingredientes,Peor),
    findall(Ing, (member(Ing,Ingredientes), Ing \= Peor), IngredientesLight).

% 5) guasada: Se cumple para una receta con algun ingrediente de mas de 1000Kcal.
guasada(Receta) :-
    receta(Receta,Ingredientes),
    member(IngredienteEngordador,Ingredientes),
    calorias(IngredienteEngordador,Kcal),
    Kcal > 1000.