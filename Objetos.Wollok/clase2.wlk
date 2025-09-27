//https://docs.google.com/document/d/1uwJOJk12lq6WQesWuVYcj0uyHSYw4XJjQk7n2Llm9iY/edit#heading=h.606768a5z1n
// ----------------------------------------
// JUGADORES
// ----------------------------------------------------------
// Pensar quien tiene que entener cada mensaje...
object julieta {
    var property tickets = 15 //atributo // property crea el mensaje tickets para lectura y escritura 
    var cansancio = 0
    
    method fuerza() = 80 - cansancio // se llama cada vez que se llame a fuerza (estaria mal hacer var fuerza = 80 - cansancio) 
    method punteria() = 20 // al ser metodo lo puedo consultar

    method jugar(juego) {
        tickets = tickets + juego.ticketsGanados(self)
        cansancio = cansancio + juego.cansancioQueProduce()
    }

    method puedeCanjear(premio) = tickets >= premio.costo()
}

object gerundio {
    method jugar() { } // Para que sea completamente polimorfico con julieta pero no guardo ningun detalle en el programa
    method puedeCanjear(premio) = true
}

// --------------------------
// JUEGOS
// --------------------------

object tiroAlBlanco {
    method ticketsGanados(jugador) = (jugador.punteria() / 10).roundUp()
    method cansancioQueProduce() = 3
}

object pruebaDeFuerza {
    method ticketsGanados(jugador) = if(jugador.fuerza() > 75) 20 else 0 // si la fuerza del jugador es mayor a 75 devuelve 20 tickets sino nada
    method cansancioQueProduce() = 8
}

object ruedaDeLaFortuna {
    var property aceitada = true
 // con property hacemos esto directamente
 //   method aceitada() = aceitada
 //   method aceitada(nuevoValor) { aceitada = nuevoValor }

    method ticketsGanados(jugador) = 0.randomUpTo(20).roundUp() // pasamos jugador solo para que sea polimorfica con tiroAlBlanco, no tiene ninguna funcion en este lugar
    // genera un numero random fraccional entre 0 y 20 (0.randomUpTo(20)) y este valor lo lee roundUp el cual lo redondea para arriba
    method cansancioQueProduce() = if(aceitada) 0 else 1
}

object robarseUnTicket {
    method ticketsGanados(jugador) = 1
    method cansancioQueProduce() = 20
}

// --------------------------
// PREMIOS
// --------------------------

object ositoDePeluche {
    method costo() = 45
}

object taladro {
    var property costo = 200 // genera el mensaje costo de lectura y escritura 
}

/* lo genera el property    
    // getter
    method tickets() = tickets // retorna lo que tenga en la variable tickets 
//wollok:clase2> :r
//✓ Reloading environment
//wollok:clase2> ✓ Dynamic diagram reloaded
//wollok:clase2> julieta.tickets()
//✓ 15

    // setter
    method tickets(nuevoValor) { // me permite cambiar el valor de tickets (wollok:clase2> julieta.tickets(20))
        tickets = nuevoValor
    }*/