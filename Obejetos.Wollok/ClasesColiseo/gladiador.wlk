// Los Gladiadores.
// Finalmente llegamos a los protagonistas de esta historia

// Para poder entrar a combatir un gladiador debe saber atacar y defenderse para no ser una presa fácil. A modo de simplificación diremos que todos los gladiadores tienen 100 unidades de vida inicialmente. En esta oportunidad contamos con dos tipos de gladiadores:

// Los mirmillones. Su estilo es uno de los más clásicos dado que salían a combatir con un arma de mano, en general una espada o gladius, más un escudo rectangular o un casco con cresta. La fuerza promedio de este tipo de gladiadores es variable y su destreza es siempre 15. Un gladiador puede cambiar su armadura.
// Los dimachaerus. Estos gladiadores peleaban con varias armas. No usaban armadura porque eran tipos duros. Los dimachaerus eran gladiadores que se valían mucho de sus habilidades, tienen una fuerza de 10 y una destreza en particular que puede ser diferente para cada gladiador.


// Y los gladiadores atacan!!
// Cuando un mirmillon ataca a cualquier gladiador le inflige al atacado tanto daño como la diferencia entre su poder de ataque y la defensa del atacado. El poder de ataque equivale al poder de su arma más su propia fuerza. Cuando un dimachaerus ataca a otro gladiador, también le inflige al atacado tanto daño como la diferencia entre su poder de ataque y la defensa del atacado, pero su poder de ataque equivale a su fuerza más la sumatoria de los poderes de todas las armas que tenga. Además, cada vez que ataca, aumenta en 1 su destreza. Para un mirmillon, su defensa se calcula como los puntos de su armadura más su destreza. Para un dimachaerus, su defensa es la mitad de su destreza.

// Se pide implementar la solución que considere necesaria para hacer que un gladiador ataque a otro.

// Pelea
// Cuando un gladiador se pelea con otro lo que hace es atacarlo. Luego de sufrir los efectos correspondientes, el gladiador atacado realiza un contraataque, mediante su propia forma de atacar.

// Grupos
// Permitir que en el coliseo haya varios grupos de gladiadores que puedan combatir contra otros grupos. De los grupos se conoce también un nombre que los representa y se registra la cantidad de peleas en las que participó. Un grupo es capaz de manejar a sus miembros (agregar o quitar gladiadores). Los combates son a tres rounds, en cada round cada grupo elige a su campeón para que pelee con el campeón adversario. El campeón debe ser el más fuerte del grupo que pueda combatir (si aún cuenta con puntos de vida disponibles) Un gladiador puede crear un grupo juntándose con otro gladiador y definiendo el nombre del grupo. Si es un mirmillon el que lo arma, le pone por nombre "mirmillolandia". Si es un dimachaerus, el nombre es por ejemplo "D-12" donde 12 es la suma de su poder de ataque y el de su colega del grupo.



import armaduras.*
import armas.*
import coliseo.*

class Mirmillon {
	const property destreza = 15
	var property vida = 100
	var fuerza = 10
	var arma
	var armadura

	method puedeCombatir() = vida > 0

	method poderAtaque() = arma.poderAtaque() + fuerza

	method defensa() = armadura.defensa(self) + self.destreza()

	method atacar(unGladiador) {
		unGladiador.recibirAtaque(self.poderAtaque())
	}

	method recibirAtaque(poderAtaque) {
		vida = vida - ( poderAtaque - self.defensa() )
	}

	method pelearContra(unGladiador) {
		self.atacar(unGladiador)
		unGladiador.atacar(self)
	}

	method masFuerte() = self

	method curar(){
		vida = 100
	}

	method armarGrupoCon(gladiador) {
		const grupo = new Grupo(nombre = "Mirmillolandia")
		grupo.agregarGladiador(self)
		grupo.agregarGladiador(gladiador)
		return grupo
	}
	
}

class Dimachaerus {
	var destreza
	const fuerza = 10
	var armas = [ ]
	var property vida = 100

	
	method puedeCombatir() {return vida > 0}

	method arma(nuevaArma) {
		armas.add(nuevaArma)
	}

	method quitarArma(arma) {
		armas.remove(arma)
	}

	method poderAtaque() = fuerza + armas.sum({ unArma => unArma.poderAtaque() })

	method atacar(unGladiador) {
		unGladiador.recibirAtaque(self.poderAtaque())
		destreza = destreza + 1
	}

	method recibirAtaque(poderAtaque) {
		vida = vida - ( poderAtaque - self.defensa() )
	}

	method defensa() = destreza / 2

	method pelearContra(unGladiador) {
		self.atacar(unGladiador)
		unGladiador.atacar(self)
	}

	method masFuerte() = self
	
	method curar(){
		vida = 100
	}

	method armarGrupoCon(gladiador) {
		const grupo = new Grupo(nombre = "D-"+(self.poderAtaque()+gladiador.poderAtaque()))
		grupo.agregarGladiador(self)
		grupo.agregarGladiador(gladiador)
		return grupo
	}
}
