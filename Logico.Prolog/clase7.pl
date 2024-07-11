% https://docs.google.com/document/d/17rWNL8rdNc-eu7VTuCPgptLhSnRD6FyBZNhYNZ7Hekc/edit#heading=h.49nyg2mvbd10

%       Festivales de Rock

% festival(NombreDelFestival, Bandas, Lugar).
% Relaciona el nombre de un festival con la lista de los nombres de bandas que tocan en él y el lugar dónde se realiza.
festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipodromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival 
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes: 
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipodromoSanIsidro, zona1, 1500).

    %%%%%%%%%
    %%% 1 %%%
    %%%%%%%%%

% Itinerante/1: Se cumple para los festivales que ocurren en más de un lugar, pero con 
% el mismo nombre y las mismas bandas en el mismo orden.
itinerante(Festival) :-
    festival(Festival,Bandas,UnLugar),
    festival(Festival,Bandas,OtroLugar),
    UnLugar\=OtroLugar.

    %%%%%%%%%
    %%% 2 %%%
    %%%%%%%%%

% careta/1: Decimos que un festival es careta si no tiene campo o si es el personalFest.
careta(personalFest).
careta(Festival) :-
    festival(Festival,_,_),
    forall(entradaVendida(Festival,TipoDeEntrada), TipoDeEntrada\=campo).
%   not(entradaVendida(Festival,campo)).

    %%%%%%%%%
    %%% 3 %%%
    %%%%%%%%%

% nacAndPop/1: Un festival es nac&pop si no es careta y todas las bandas que 
% tocan en él son de nacionalidad argentina y tienen popularidad mayor a 1000.
nacAndPop(Festival) :-
    festival(Festival,Bandas,_),
    forall(member(Banda,Bandas), (banda(Banda,argentina,Popularitdad), Popularitdad > 1000)),
    not(careta(Festival)).

    %%%%%%%%%
    %%% 4 %%%
    %%%%%%%%%

% sobrevendido/1: Se cumple para los festivales que vendieron más entradas que 
% la capacidad del lugar donde se realizan.

% Nota: no hace falta contemplar si es un festival itinerante.
sobrevendido(Festival) :-
    festival(Festival, _ , Lugar),
    lugar(Lugar, Capacidad, _),
    findall(Entrada, entradaVendida(Festival, Entrada), ListaEntradas),
    length(ListaEntradas, CantidadEntradas),
    CantidadEntradas > Capacidad.

    %%%%%%%%%
    %%% 5 %%%
    %%%%%%%%%

% recaudaciónTotal/2: Relaciona un festival con el total recaudado con la venta de entradas. 
% Cada tipo de entrada se vende a un precio diferente:
%    - El precio del campo es el precio base del lugar donde se realiza el festival.
%    - La platea general es el precio base del lugar más el plus que se p aplica a la zona. 
%    - Las plateas numeradas salen el triple del precio base para las filas de atrás (>10) 
%      y 6 veces el precio base para las 10 primeras filas.
 
% Nota: no hace falta contemplar si es un festival itinerante.
recaudaciónTotal(Festival,TotRecaudado) :-
    festival(Festival,_,Lugar),
    findall(Precio,(entradaVendida(Festival,Entrada),precio(Entrada,Lugar,Precio)),Precios),
    sumlist(Precios, Recaudacion).

precio(campo,Lugar,Precio) :- lugar(Lugar,_,Precio).
precio(plateaGeneral(Zona),Lugar,Precio) :-
    lugar(Lugar,_,PrecioBase),
    plusZona(Lugar,Zona,Plus),
    Precio is PrecioBase + Plus.
precio(plateaNumerada(Fila),Lugar,Precio) :-
    Fila =< 10, %Fila no es inversible pero no nos importa en este caso por como esta hecho el findall(si esta al reves se rompe)
    lugar(Lugar,_,PrecioBase),
    Precio is PrecioBase * 6. %EL IS NO ES INVERSIBLE
precio(plateaNumerada(Fila),Lugar,Precio) :-
    Fila > 10,
    lugar(Lugar,_,PrecioBase),
    Precio is PrecioBase * 3.

    %%%%%%%%%
    %%% 6 %%%
    %%%%%%%%%

% delMismoPalo/2: Relaciona dos bandas si tocaron juntas en algún recital o si una de ellas 
% tocó con una banda del mismo palo que la otra, pero más popular.
delMismoPalo(Banda1,Banda2) :- tocoCon(Banda1,Banda2).
delMismoPalo(Banda1,Banda2) :-
    tocoCon(Banda1,TercerBanda),
    banda(TercerBanda,_,PopularidadTercerBanda),
    banda(Banda2,_,PopularidadBanda2),
    PopularidadTercerBanda > PopularidadBanda2,
    delMismoPalo(TercerBanda,Banda2).

tocoCon(Banda1,Banda2) :-
    festival(_, Bandas, _),
    member(Banda1,Bandas),
    member(Banda2,Bandas),
    Banda1\=Banda2.

