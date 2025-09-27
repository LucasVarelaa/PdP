class Persona{
    var edad
    var emociones = []

    method esAdolescente() = edad.between(12, 19)

    method tenerEmocion(emocion) {
        emociones.add(emocion)
        }

    method estaPorExplotar() = emociones.all{ e => e.puedeLiberarse() }

    method vivir(evento){
        emociones.forEach{e=>e.intentarLiberarse(evento)}
    }

}

object intensamente{
    var property intensidadLimite = 10
    var personas = []

    method agregarPersona(persona){
        personas.add(persona)
        }

    method cantPersonasPorExplotar() = personas.count{ p => p.estaPorExplotar() } 

    method todosViven(evento){
        personas.forEach{ p => p.vivir(evento) }
    }
}

class Emocion{
    var cantEventos = 0
    var property intensidad 

    // method liberar(emocion) = emocion.puedeLiberarse()

    method puedeLiberarse() =  
        intensidad > intensamente.intensidadLimite() and 
        self.condicionAdicional()

    method liberarse(evento){
        intensidad -= evento.impacto()
    }

    method intentarLiberarse(evento){
        if(self.puedeLiberarse()){
            self.liberarse(evento)
            cantEventos += 1
        }
        else{
            throw new Exception(message = "No se puede liberar la emoción")
        }
    }

    method condicionAdicional() // la defino en cada subclase
}

class Furia inherits Emocion(intensidad=100){
    var palabrotas = []

    method aprenderPalabrota(palabrabrota){
        palabrotas.add(palabrabrota)
        }

    override method condicionAdicional() = palabrotas.any{ p => p.size() >= 7 }

    override method liberarse(evento){
        super(evento)
        palabrotas.remove(palabrotas.first())
        
    }
}

class Alegria inherits Emocion{
    override method condicionAdicional() =  
        cantEventos.even()
    
    override method intensidad(valor){
        intensidad = valor.abs()
    }
}

class Tristeza inherits Emocion {
    var property causa = "melancolia"
    override method condicionAdicional() =  
        causa != "melancolia"
    override method liberarse(evento){
        super(evento)
        causa = evento.descripcion()
    } 
}

class OtraEmocion inherits Emocion {
    override method condicionAdicional() =  
        cantEventos > intensidad
}

class Ansiedad inherits Furia{
    override method liberarse(evento) {
        
    }
}

class Evento{
    var property impacto
    var property descripcion
}