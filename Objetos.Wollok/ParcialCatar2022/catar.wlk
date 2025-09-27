class Plato{
    method esBbonito()
    method azucar()
// 1
    method caloriaPlato() = 3 * self.azucar() + 100
}

class Entrada inherits Plato{
    override method azucar() = 0
    override method esBbonito() = true
}

class Principal inherits Plato{
    var azucar
    var esBonito

    override method azucar() = azucar
    override method esBbonito() = esBonito
}

class Postre inherits Plato{
    var cantColores
    override method azucar() = 120
    override method esBbonito() = cantColores > 3
}

class Cocinero{
    var especialidad
// 2
    method catarYDarCalificacion(plato) = especialidad.puntaje(plato)
// 3
    method cambiarEspecialidad(cual){
        especialidad = cual
    }
// 5
    method cocinar() = especialidad.cocinar()

// 6 A
    method participar(torneo){
        const platoParticipante = new PlatoPresentado(plato = self.cocinar(), creador = self)
        torneo.agregarPlato(platoParticipante)
    }
}

class PlatoPresentado{
    var plato
    var creador
    method creador() = creador
    method plato() = plato
}

class Chef{
    const cantCaloriasDeseadas
    method puntaje(plato){
        if(self.cumpleCriterio(plato)){
            return 10
        }
        else{
            return 0
        }
    }

    method cumpleCriterio(plato) = plato.esBbonito() && plato.azucar() <= cantCaloriasDeseadas 

    method cocinar() = new Principal(esBonito = true, azucar = cantCaloriasDeseadas)
}

class Pastelero{
    var dulzorDeseado
    method puntaje(plato) = (5 * plato.azucar()/dulzorDeseado).min(10)
    // agarra el minimo entre lo que nos de y 10 (como maximo puede ser 10 entonces si da 13 se pasa y agarra el min entre 13 y 10 osea 10)
    // cuando digan el minimos es x, habria que poner un .max(x) y lo mismo al reves con maximo y min
    method cocinar() = new Postre(cantColores = dulzorDeseado/50)
}

// 4
class Souschef inherits Chef{
    override method puntaje(plato){
        if(self.cumpleCriterio(plato)){
            return super(plato) // 10
        }
        else{
            return (plato.caloriaPlato()/100).min(6)
        }
    }

    override method cocinar() = new Entrada()
}

class Torneo{
    const catadores = []
    var platosPresentados = []

    method agregarPlato(plato) {
        platosPresentados.add(plato)
    }

    // 6 b
    method cocineroGanador(){
        if(platosPresentados.isEmpty()){
            return throw new DomainException(message ="No se presentaron participantes")
        }
        else{
            return self.platoPresentadoGanador().creador()
        }
    }

    method platoPresentadoGanador() = platosPresentados.max({platoPresentado => self.puntajeTotal(platoPresentado.plato())})

    method puntajeTotal(plato) = catadores.sum({catador => catador.catarPlato(plato)})
}