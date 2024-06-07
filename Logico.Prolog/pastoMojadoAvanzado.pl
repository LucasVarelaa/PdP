% Mayuscula para VARIABLES - minusculas para individuos

clima(caba,lluvia,10).
clima(cordoba,sol,23).
clima(rosario,lluvia,100).

ubicacion(pasto,caba).
ubicacion(vereda,cordoba).
ubicacion(jardin,rosario).

seRego(canchaFutbol).

alAireLibre(pasto).
alAireLibre(jardin).

llovioMucho(Ciudad):-
    clima(Ciudad,lluvia,Cantidad),
    Cantidad > 20.

seMojo(Lugar) :- seRego(Lugar).
seMojo(Lugar) :-
    alAireLibre(Lugar),
    ubicacion(Lugar,Ciudad),
    llovioMucho(Ciudad).