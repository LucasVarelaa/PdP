object cartaPikachu{
    method valor() = 10

    method revalorizar() {
      // Esto solo se usa para que el method sea polimorfico con las demas cartas
    }
}

object cartaYugiOh{
    var valor = 100
    method valor() = valor

    method revalorizar(){
      valor *= 2
    }
}

object anchoDeEspadas{
    var antiguedad = 100

    method valor() = antiguedad * 7

    method revalorizar() {
      antiguedad += 1
    }
}

object juanCruz{

    const cartas = [] // Al ppio juan cruz no tiene cartas. La estructura puede ser constante porque modificamos su contenido, pero no su estructura.
    // Si tirara su coleccion de cartas para hacer otra coleccion, por ahí convendría hacerla constante
    var dinero = 0

    method conseguirCarta(unaCarta){
        cartas.add(unaCarta) // Agregar una carta a la colección
    }

    method tieneCarta(unaCarta) = cartas.contains(unaCarta) // No hacemos funciones ni predicados, le mandamos un mensaje a la lista de cartas

    method vender(){
        dinero = dinero + cartas.first().valor()
        cartas.remove(cartas.first())
    }

    method cuantaPlataTenes() = dinero

    //method cuantasCartas()= if(carta==null)0 else 1  // Yo quiero que cuando esté juntando varias recuerde todas las cartas, no que se olvide de las anteriores

    // Lo que nos falta acá es una LISTA. Se las suele llamar colecciones

    method cuantasCartas() = cartas.size() // El metodo le pregunta a cartas su length

    // la sumatoria del valor de cada elemento de la coleccion
    method cotizacion() = cartas.sum({carta => carta.valor()}) // Se evalua el bloque para un elemento en particular
    // sum aplica el bloque a cada elemento de la colección(lista)

    method tieneAlgunaCartaMuyValiosa() = cartas.any({carta => carta.valor() > 200})

    // Devuelve una lista de las cartas muy valiosas
    method lasCartasMuyValiosas() = cartas.filter({carta => carta.valor() > 200})

    // Map devuelve una lista de valores preguntados
    method listaDeValores() = cartas.map({carta => carta.valor()})

    // Devolver la carta de mayor valor... coleccion.max({bloqueOrdenable})
    method cartaMasValiosa() = cartas.max({carta => carta.valor()})

    // Este metodo no retorna nada
    method visitaExperto() {
      cartas.forEach({carta => carta.revalorizar()})
    }
}