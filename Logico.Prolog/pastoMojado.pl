% Mayuscula para VARIABLES - minusculas para individuos

esHombre(socrates).
esHombre(juanPerez).

esPersonajeFiccion(darthvader).

esMortal(Alguien) :- esHombre(Alguien).
% si es hombre entonces es mortal

clima(lluvia,100).

seRego(pasto).
seRego(vereda).

alAireLibre(auto).
alAireLibre(perro).

seMojo(Lugar) :- seRego(Lugar).
%se mojo un lugar si se rego ese lugar
seMojo(Lugar) :- alAireLibre(Lugar), clima(lluvia,Cantidad), Cantidad > 20.
% se mojo el lugar si esta al aire libre Y si llovio donde cantidad es mayor 20

/*

swipl
consult('numero_letra'). -- para cargar o recargar el archivo ante una modificacion o comienzo.
make. -- recargar el archivo

esHombre(X).
X = socrates ; -- ; sirve para dar mas respuestas a los casos que son Hombres
X = juanPerez.

*/
