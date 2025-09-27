class Planeta {
    var habitantes = []
    var construcciones = []
    
    method delegacion() = (self.habitantesDestacados() + [self.elMasRico()]).asSet()

    method elMasRico() = habitantes.max{h => h.recursos()}

    method habitantesDestacados() = habitantes.filter{h => h.esDestacada()}

    method esValioso() = construcciones.sum{c => c.valor()} > 100

    method vive(persona) = habitantes.contains(persona)

    method agregarConstruccion(construccion) = construcciones.add(construccion)
}