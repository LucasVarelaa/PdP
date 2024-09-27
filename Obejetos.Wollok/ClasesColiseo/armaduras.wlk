// Como de estas peleas no siempre salían todos los que entraban a la arena, muchos gladiadores no se valían solo de sus habilidades de pelea sino que llevaban algo de armadura. Por lo general usaban cascos y escudos para intentar parar los ataques del enemigo o no sufrir una herida letal (al menos no tan rápido). Los cascos les brindan 5 puntos de armadura a su portador, los escudos por su parte suman 10 más el 10% de la destreza del luchador.

object casco {
	method defensa(unGladiador) {
		return 5
	}
}

object escudo {
	const defensa = 10
	method defensa(unGladiador) {
		return defensa + unGladiador.destreza() / 10
	}
}