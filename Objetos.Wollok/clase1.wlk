object pepita {
  var energia = 100

  method vola(kilometros) {
    energia = energia - kilometros * 2
  }

  method come(gramos) {
    energia = energia + gramos * 10
  }

  // Si algo esta definido entre llaves (como los 2 ejemplos de arriba)
  // NO retornan nada salvo que usen un return
  // En cambio los que no usan llaves como el ejemplo de abajo que se usa un =
  // Siempre retornan un objeto (por lo que vimos hasta ahora)

  method energia() = energia
  
}

object emilia {
  method entrena(ave) {
    ave.come(5)
    ave.vola(10)
    ave.come(5)
  }
}

object ramiro {
    var horasDormidas = 0

  method horasDormidas() = horasDormidas // getter (devuelve el valor del atributo horasDormidas

  method horasDormidas(horas) { // setter (modifica el valor del atributo horasDormidas al valor que se pasa como argumento.)
    horasDormidas = horas
  }

  method estaDeBuenHumor() = horasDormidas >= 8 

  method entrena(ave) {
    const distancia = if(self.estaDeBuenHumor()) 15 else 30
    ave.vola(distancia)
    // self representa "este objeto" => si ramiro.estaDeBuenHumor() 15 sino 30
  }
}

/*
wollok:clase1> pepita.energia()
✓ 100
wollok:clase1> emilia.entrena(pepita)
✓
wollok:clase1> pepita.energia()
✓ 180

ERROR COMUN de tipos
wollok:clase1> emilia.entrena(10)
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodException: 10 does not understand come(arg 0)
    at clase1.emilia.entrena(ave) [clase1.wlk:22]

OTRO ERROR... a los objetos solo se le pueden pasar mensajes
wollok:clase1> pepita.energia(10)
✗ Evaluation Error!
  wollok.lang.MessageNotUnderstoodException: pepita does not understand energia(arg 0)
*/

//POLIMORFISMO

object pepote {
  var volado = 0
  var comido = 0

  method vola(kilometros) {
    volado = volado + kilometros
  }

  method come(gramos) {
    comido = comido + gramos
  }

  method energia() = 255 + comido ** 2 - volado / 5
    
}

// Decimos que tanto pepito como pepote son polimorficos para emilia
// Emilia sabe trabajar con aves, que le pasen que come y que vuela
// No necesita un nombre en especifico y por eso es polimorfica
// No le importa que ave reciba, lee y manda la info sin importar cual sea
// El entrenamiento de emilia funciona siempre y cuando no le cambies la interfaz


// NO ES POLIMORFICO, no es entrenable por emilia

object pepaza {
  var recorrido = 0
  var comido = 0

  method volar(kilometros) { // No es polimorfica ya que emilia conoce VOLA y no volar
    recorrido = recorrido + kilometros
  }

  method come() { // NO ES POLIMORFICA PORQUE DEBE PASAR UN PARAMETRO PARA QUE EMILIA ENTIENDA
  // si es necesario poner (gramos) para que sea polimorfico aunque no lo usemos en el mismo method
    comido = comido + 10 
  }

  method nadar(kilometros) { // Que haya method extra no arruina nada, por lo tanto no produce error al llamar a emilia
    recorrido = recorrido + kilometros
  }
    
}
// Entonces se solucionaria si ponemos vola en vez de volar y si en come le pasamos un parametro aunque no lo usemos

object pepudo {
  var recorrido = 0
  var comido = 0

  method come(gramos) { 
    comido = comido + gramos 
  }

  method nada(kilometros) { // Que haya method extra no arruina nada, por lo tanto no produce error al llamar a emilia
    recorrido = recorrido + kilometros
  }
    
} // PERO NO es polimorfica ya que no se le pasa Vola
// Para que sea tiene que pasar como minimo los method que emilia necesita para entrenar un animal