class Persona{
    var property monedas = 20
    var edad = 0

    method esDestacada() = edad.between(18, 65) || self.recursos() >= 30

    method ganar(cantidad) { 
        monedas += cantidad 
        }
    method gastarMonedas(cantidad) {
        self.ganar(-cantidad)
    }
    method cumplirAnios() {
        edad += 1
    }

    method recursos() = monedas

    method trabajarEn(duracion,planeta){}

    method inteligencia() = 5

}

class Productor inherits Persona {
    var tecnicas = ["cultivo"]

    override method recursos() = super() * self.cantidadTecnicas()

    method cantidadTecnicas() = tecnicas.size()

    override method esDestacada() = super() || self.cantidadTecnicas() > 5

    method realizarTecnica(duracion,tecnica){
        if(self.conoceTecnica(tecnica)){
            self.ganar(3*duracion)
        }
        else{
            self.gastarMonedas(1)
        }
    }

    method conoceTecnica(tecnica) = tecnicas.contains(tecnica)

    method aprenderTecnica(nuevaTecnica) = tecnicas.add(nuevaTecnica)

    override method trabajarEn(duracion,planeta){
        if(planeta.vive(self)){
            self.realizarTecnica(duracion, self.ultimaTecnica())
        }
    }

    method ultimaTecnica() = tecnicas.last()

}

class Constructor inherits Persona {
    var property cantidadConstrucciones = 0
    var property regionDelPlaneta

    override method recursos() = super() + cantidadConstrucciones * 10

    override method esDestacada() =  cantidadConstrucciones >= 5

    override method trabajarEn(duracion,planeta){
        self.gastarMonedas(5)
        planeta.agregarConstruccion(regionDelPlaneta.queConstruir(duracion,self))
        cantidadConstrucciones += 1
    }
}