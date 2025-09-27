class Chico{
    var elementos = []
    const actitud
    var property caramelos
    var salud = sano

    method capacidadSusto() = self.sustoElementos() * self.actitud()

    method actitud() = actitud * salud.coeficiente()

    method sustoElementos() = elementos.sum{ e => e.capacidadSusto() }

    method ponerse(elemento) = elementos.add(elemento)

    method recibirCaramelos(cantidad){
        caramelos += cantidad
    }

    method intentarAsustar(persona){
        if(persona.seAsusta(self)){
            self.recibirCaramelos(persona.darCaramelo(self))
        }
    }

    method comerCaramelos(cantidad){
        if(caramelos >= cantidad){
            caramelos -= cantidad
            salud.comerCaramelo(cantidad,self)
        }
        else{
            throw new DomainException(message = "caramelosInsuficientes")
        }
    }
}

object maquillaje{
    method capacidadSusto() = 3
}

class TrajeTierno{
    method capacidadSusto() = 2
}

class TrajeTerrorifico{
    method capacidadSusto() = 5
}

object sano{
    method coeficiente() = 1

    method comerCaramelo(caramelos,chico){
        if(caramelos >10){
            chico.salud(empachado)
     }
    }
}

object empachado {
	method coeficiente() = 0.5
	
	method comerCaramelos(cantidad, chico) {
		if (cantidad > 10) chico.salud(enCama)
	}
}

object enCama {
	method coeficiente() = 0
	
	method comerCaramelos(cantidad, chico) {
		throw new DomainException(message = "noComeCaramelosException")
	}
}