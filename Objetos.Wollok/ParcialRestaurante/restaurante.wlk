object escuela{
    var estudiantes = []
    var profesores = []

    method esProfesor(persona) = profesores.contains(persona) 
}

class Estudiante{
    var property dinero
    var property platosComidos
    var property salioDeGira = false
    var property categoria = principiante
    

    method esBuenaOnda()

    method puedeIr(costo) = self.esBuenaOnda() && dinero >= costo

    method comer(){
        platosComidos += 1
    }
    method pagar(importe){
        dinero -= importe
    }
    method recategorizar() {
		if (categoria.puedeAscender(self)) {
            categoria.ascenderA(self)
        }
	}
}

class Deglutidor inherits Estudiante{
    const tieneAuto

    override method esBuenaOnda() = platosComidos > 20 || tieneAuto

    method premioClasico(){
        platosComidos += 3
    }
    
}

class CriticoCulinario inherits Estudiante{
    var horasPrograma
    override method esBuenaOnda() = platosComidos <= horasPrograma.div(10)

    method premioClasico(){
        horasPrograma = horasPrograma * 1.10
    }

}

class Gira{
    var casasComidas = []
    //const costoEstimado
    var property personas = []
    var costoEstimadoPorPersona 

    method valePena() = casasComidas.all{ c => c.valePena()}

    method comerEn(casa) {
		const importe = casa.costoPorPersona(self.cantidadPersonas())
		personas.forEach({ persona =>	
			persona.comer()
			persona.pagar(importe)
		})
	}

    method agregarPersona(persona){
        if(persona.puedeIr(costoEstimadoPorPersona)){
            personas.add(persona)
            persona.salioDeGira(true)
        }
        else{
            throw new Exception(message = "No se pudo agregar a la gira")
        }
    }

    method cantidadPersonas() = personas.size()
}


class CasaComida{
    var carta  
    var calificacion

    method costoPorPersona(cantidad) = carta.take(cantidad).sum{ p => p.costo() } / cantidad 
}
class Bodegon inherits CasaComida{

    method valePena(cantPersonas) = carta >= cantPersonas
}

class Restaurante inherits CasaComida{
    var chef

    method valePena() = calificacion >= 3 && chef.esFamosoOprofesor()
}

class RestauranteEtnico inherits Restaurante{
    const lugar

    override method valePena() = !lugar.esExotico()
}

class Lugar{
    var property esExotico
    
}
class Chef{
    method esFamoso() = true

    method esFamosoOprofesor() = self.esFamoso() || escuela.esProfesor(self)
}

class Plato{
    var nombre
    var property costo
}

// SEGUNDA PARTE


object principiante{
    var platosComidos =0

    method puedeAscender(persona) = persona.salioDeGira()

     method ascenderA(persona){
        persona.categoria(clasico)
        persona.premioClasico()
     }
}

object clasico{
    method puedeAscender(persona) = persona.esBuenaOnda()

    method ascenderA(persona){
        persona.categoria(experto)
     }
}

object experto{
    method ascenderA(persona) = false
}