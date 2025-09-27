import wollok.game.*

object pepita {
  var property energia = 50
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
  const position = game.at(1.randomUpTo(15), 2)

  method position() = position

  method image() = "alpiste.png"
  
  method energia() = 50
}


object manzana {
  const position = game.at(1.randomUpTo(15), 15)

  method position() = position

  method image() = "manzanita.png"

  method reaccionar(alguien){
    game.say(alguien, {alguien.comer(self)})
  }

  method energia() = 100
}

object nido {
  const position = game.at(15, 15)

  method position() = position

  method image() = "nido.png"

  method reaccionar(alguien){
    game.say(self, "ganaste!!")
    game.removeTickEvent("movimiento")
    game.schedule(2000,{game.stop()})
  }

  
}

	
  