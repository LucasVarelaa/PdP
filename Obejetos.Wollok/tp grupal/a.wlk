/*
El señor oscuro quiere recuperar su anillo (convengamos que es bastante llorón al respecto). 
Está modelando un sistema en Wollok para representar los caminos de la Tierra Media, y nos ofreció
muy gentilmente la posibilidad de elegir entre darle una mano (la que medio le falta) o 
terminar en el fondo de Orodruin, también conocido como Monte del Destino. Su idea es la de representar
algunas cuestiones de la Tierra Media, para poder determinar dónde encontrar su anillo, de forma tal de poder 
llevarlo al lugar al que corresponde... que viene a ser su dedo, básicamente

Gandalf
Existen diversos guerreros que pueden estar vagando por la Tierra Media, portando el anillo por ahí, como si nada estuviera pasando.
Uno de ellos es Gandalf “El Gris”, como se lo conoce normalmente (porque tiene varios nombres, 
varían dependiendo a quien se le pregunte). Gandalf tiene un nivel de vida que es entre 0 y 100.
Lleva consigo ciertas armas, como su báculo y su espada, Glamdring.
Su poder se calcula como:
	cantidad de vida * 15 + Sumatoria del Poder de sus Armas * 2
En el caso de que su vida sea menor a 10, la fórmula cambia de la siguiente manera:
	cantidad de vida * 300 + Sumatoria del Poder de sus Armas * 2
El báculo a Gandalf le otorga un poder fijo de 400. En el caso de la espada, el poder que otorga es de 10 veces 
por el valor dado por su origen, en este caso es élfico y vale 25. Si fuera enano, serían 20, y 15 en el caso humano.

*/

object gandalfGris {
  const vida = 100

  const armas = [baculo, glamdring]

  method sumarPoderArmas() = armas.sum({arma => arma.poder()})
  method poder() {
    if (vida < 10) {
      return vida * 300 + self.sumarPoderArmas() * 2
    }
    else {
      return vida * 15 + self.sumarPoderArmas() * 2
    }
  }

}

object baculo {
  method poder() = 400
}

object glamdring {
  const origen = "élfico" 

    method poder() {
        if (origen == "élfico") {
            return 25 * 10
        } else if (origen == "enano") {
            return 20 * 10
        } else {
            return 15 * 10
        }
    }
}