import wollok.game.*

object pepita {
  var energia = 50
  var position = game.at(8, 8) // Metodo position devuelve un objeto
  
  method position() = position
  
  method position(newPos) {
    // Metodo setter, me permite cambiar el valor de la variable position
    self.volar(1)
    position = newPos
  }
  
  method image() = "jugador.png"
  
  method energia() = energia
  
  method estaCansada() = energia <= 20
  
  method volar(minutos) {
    energia -= minutos
  }
  
  method comer(comida) {
    energia = energia + 25
  }
}

object alpiste {

  // Posicion del alpiste aleatoria
  const position = game.at(5.randomUpTo(15), 5.randomUpTo(15))

  method position() = position

  method image() = "alpiste.png"
  
  method energia() = 5
}


object manzana {
  const position = game.at(5.randomUpTo(15), 5.randomUpTo(15))

  method position() = position

  method image() = "manzanita.png"
}

object nido {
  const position = game.at(15, 15)

  method position() = position

  method image() = "nido.png"

  
}

	
  