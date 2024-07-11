% La información con la que se cuenta describe las principales características de los episodios.
%apareceEn( Personaje, Episodio, Lado de la luz).
apareceEn( luke, elImperioContrataca, luminoso).
apareceEn( luke, unaNuevaEsperanza, luminoso).
apareceEn( vader, elImperioContrataca, oscuro).
apareceEn( vader, laVenganzaDeLosSith, luminoso).
apareceEn( vader, laAmenazaFantasma, luminoso).
apareceEn( c3po, laAmenazaFantasma, luminoso).
apareceEn( c3po, unaNuevaEsperanza, luminoso).
apareceEn( c3po, elImperioContrataca, luminoso).
apareceEn( chewbacca, elImperioContrataca, luminoso).
apareceEn( yoda, elAtaqueDeLosClones, luminoso).
apareceEn( yoda, laAmenazaFantasma, luminoso).

%Maestro(Personaje)
maestro(luke).
maestro(leia).
maestro(vader).
maestro(yoda).
maestro(rey).
maestro(duku).

%caracterizacion(Personaje,Aspecto).
%aspectos:
% ser(Especie,Tamaño)
% humano
% robot(Forma)
caracterizacion(chewbacca,ser(wookiee,10)).
caracterizacion(luke,humano).
caracterizacion(vader,humano).
caracterizacion(yoda,ser(desconocido,5)).
caracterizacion(jabba,ser(hutt,20)).
caracterizacion(c3po,robot(humanoide)).
caracterizacion(bb8,robot(esfera)).
caracterizacion(r2d2,robot(secarropas)).

%elementosPresentes(Episodio, Dispositivos)
elementosPresentes(laAmenazaFantasma, [sableLaser]).
elementosPresentes(elAtaqueDeLosClones, [sableLaser, clon]).
elementosPresentes(laVenganzaDeLosSith, [sableLaser, mascara, estrellaMuerte]).
elementosPresentes(unaNuevaEsperanza, [estrellaMuerte, sableLaser, halconMilenario]).
elementosPresentes(elImperioContrataca, [mapaEstelar, estrellaMuerte] ).


% El orden de los episodios se representa de la siguiente manera:
%precede(EpisodioAnterior,EpisodioSiguiente)
precedeA(laAmenazaFantasma,elAtaqueDeLosClones).
precedeA(elAtaqueDeLosClones,laVenganzaDeLosSith).
precedeA(laVenganzaDeLosSith,unaNuevaEsperanza).
precedeA(unaNuevaEsperanza,elImperioContrataca).

%-----------------------------------------------------------------------------------%

% Para mantener el espíritu clásico, el héroe tiene que ser un jedi (un maestro que estuvo alguna vez en el lado luminoso)
% que nunca se haya pasado al lado oscuro. 
esHeroe(Heroe) :-
    maestro(Heroe),
    apareceEn(Heroe, _, luminoso),
    not(apareceEn(Heroe, _, oscuro)).
/*
14 ?- esHeroe(vader).
false.

15 ?- esHeroe(luke).
true
*/

% El villano debe haber estado en más de un episodio y tiene que mantener algún rasgo de ambigüedad,
% por lo que se debe garantizar que haya aparecido del lado luminoso en algún episodio y del lado oscuro
% en el mismo episodio o en un episodio posterior.

esVillano(Villano) :-
    apareceEn(Villano, Episodio1, luminoso),
    apareceEn(Villano, Episodio2, oscuro),
    Episodio1 == Episodio2.
esVillano(Villano) :-
    apareceEn(Villano, Episodio1, luminoso),
    apareceEn(Villano, Episodio2, oscuro),
    episodioPosterior(Episodio1, Episodio2).

    % Un episodio es posterior a sí mismo o a otro episodio en la secuencia
episodioPosterior(EpisodioAnterior, EpisodioPosterior) :-
    precedeA(EpisodioAnterior, EpisodioPosterior). % si es el que le sigue da verdadero de una
episodioPosterior(EpisodioAnterior, EpisodioPosterior) :-
    precedeA(EpisodioAnterior, Intermedio), % Prolog matchea el episodio que le dimos con su posterior inmediato
    episodioPosterior(Intermedio, EpisodioPosterior). % busca el posterior del inmediato hasta encontrar nuestro EpisodioPosterior

/*
27 ?- esVillano(vader).
true .

28 ?- esVillano(luke).
false.
*/


% El extra tiene que ser un personaje de aspecto exótico para mantener la estética de la saga.
% Tiene que tener un vínculo estrecho con los protagonistas, que consiste en que haya estado junto
% al heroe o al villano en todos los episodios en los que apareció. Se considera exótico a los robots
% que no tengan forma de esfera y a los seres de gran tamaño (mayor a 15) o de especie desconocida.

esExtraDe(Extra, Protagonista) :-
    esExotico(Extra),
    forall(apareceEn(Extra,Episodio,_) , apareceEn(Villano,Episodio,_)).

esExotico(Extra) :-
    caracterizacion(Extra,ser(_,Tamanio)), 
    Tamanio > 15.
esExotico(Extra) :-
    caracterizacion(Extra, robot(Forma)),
    Forma \= esfera.
esExotico(Extra) :-
    caracterizacion(Extra,ser(desconocido,_)).
    
% El dispositivo tiene que ser reconocible en el publico, por lo que tiene que ser un elemeto
% que haya estado presente en muchos episodios(3 o mas)

% Verificar si un dispositivo es reconocible en la saga (aparece en 3 o más episodios)
esReconocible(Dispositivo):-
    elementosPresentes(_,Disp),
    member(Dispositivo,Disp),
    findall(Episodio, (elementosPresentes(Episodio,Dispositivos),member(Dispositivo,Dispositivos)),ListaEpisodios),
    length(ListaEpisodios,N), N >= 3.

    
/*
3 ?- esReconocible(sableLaser).
true.

5 ?- esReconocible(mapaEstelar).
false.

6 ?- esReconocible(estrellaMuerte).
true.
*/

%%%% OBJETIVO PRINCIPAL %%%%

% El objetivo principal es deducir las principales características del próximo episodio. 

% En particular, se busca definir un predicado que permita relacionar a un personaje que sea el héroe 

% del episodio con su correspondiente villano, junto con un personaje extra que le aporta mística 

% y un dispositivo especial que resulta importante para la trama.

% Se deben cumplir las condiciones que defini arriba

% 1) verificar si una determinada conformacion del episodio es valida:
% ej: nuevoEpisodio(luke, vader, c3po, estrellaMuerte). True
nuevoEpisodio(Heroe,Villano,Extra,Dispositivo) :-
    esHeroe(Heroe), 
    esVillano(Villano), 
    esExotico(Extra),
    esReconocible(Dispositivo).
/*
7 ?- nuevoEpisodio(luke, vader, c3po, sableLaser).
true.

8 ?- nuevoEpisodio(luke, vader, bb8, sableLaser).
false.

9 ?- nuevoEpisodio(luke, vader, chewbacca, estrellaMuerte).
false.

% PUNTO 2
% Encontrar todas las conformaciones posibles que se puedan armar.
% Mostrar ejemplos de consultas y respuestas

10 ?- nuevoEpisodio(Heroe,Villano,Extra,Dispositivo).
*/

% PUNTO 3
% Agregar nuevos personajes y lógica para el extra:

% Nuevo personaje y caracterización:
caracterizacion(grogu, ser(desconocido, 2)). % Grogu es de una especie desconocida y de pequeño tamaño.

% Lógica para ser incluido como extra:
esExotico(grogu). % Grogu es exótico por ser de especie desconocida y pequeño.

% Definimos que Grogu está vinculado estrechamente con los protagonistas:
esExtraDe(grogu, Protagonista) :-
    apareceEn(grogu, Episodio, _),
    apareceEn(Protagonista, Episodio, _).

% Ejemplo de consulta:
/*
?- esExtraDe(grogu, luke).
true.
*/

% Con esto, Grogu puede ser considerado como un "extra" en los episodios de la saga.
