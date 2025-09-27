import hechizos.*
import casas.*

class Bot{
    var property cargaElectrica = 0
    var property aceitePuro = false

    method sufrirConsecuencias(hechizo)

    method cantEstudiantesPuros()

    method disminuirCargaElectrica(cantidad) {
        cargaElectrica -= cantidad
        }

    method anularCargaElectrica() {
        cargaElectrica = 0
    }

    method volversucio() {
        self.aceitePuro(false)
    }

    method esActivo() = cargaElectrica != 0
}

object howarts{
    var property casas = [gryffindor, slytherin, ravenclaw, hufflepuff]
    var property materias = [] 

    method casasPeligrosas() = casas.filter{ c => c.esPeligrosa()}

    method crearMateria(nombre,prof,hechizo){
        const materia = new Materia(profesor = prof, hechizoEnseniado = hechizo)
        self.materias().add(materia)
        prof.materiasDictadas().add(materia)
    }

    method asistirA(materia,grupo){
        grupo.forEach{ e => e.asistirA(materia)}
    }
}

class Hechicero inherits Bot{
    var hechizosAprendidos = []
    var property casa 

    method sabeHechizo(hechizo) = hechizosAprendidos.contains(hechizo)

    method puedeLanzarHechizo(hechizo) = 
        self.cumpleRequisito(hechizo) && self.esActivo() && self.sabeHechizo(hechizo)

    method esExperimentado() = hechizosAprendidos.size() > 3 && cargaElectrica > 50

    method cumpleRequisito(hechizo) = hechizo.cumpleRequisitos(self)

    method lanzarHechizo(hechizo, bot) {
        if(self.puedeLanzarHechizo(hechizo)) {
            hechizo.efectoHechizo(bot)
        }
        else{
            throw new Exception(message = "No se puede lanzar el hechizo")
        }
    }
}

class Profesor inherits Hechicero{
    var property materiasDictadas = []
    override method esExperimentado() = super() && materiasDictadas.size() > 3
    method defenderse(hechizo){
        cargaElectrica = cargaElectrica / 2
    }
}

class Estudiante inherits Hechicero{
    method aprenderHechizo(hechizo) = hechizosAprendidos.add(hechizo)

    //method esExperimentado() = hechizosAprendidos.size() > 3 && cargaElectrica > 50// lo hereda
}

class Materia{
    var profesor
    var property hechizoEnseniado
}