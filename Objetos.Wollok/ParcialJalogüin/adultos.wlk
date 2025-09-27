class Adulto{
    const asustadores = []

    method tolerancia() = 10 * asustadores.count{ a => a.caramelos() > 15}

    method darCaramelo(chico) = chico.recibirCaramelos(self.tolerancia() / 2) 

    method seAsusta(chico) = self.tolerancia() < chico.capacidadSusto()

    method serAsustadoPor(chico){
        if(self.seAsusta(chico)) {
            chico.recibirCaramelos(self.darCaramelo(chico))
        }
        asustadores.add(chico)
    }
}

class Abuelo inherits Adulto{
    override method seAsusta(chico) = true

    override method darCaramelo(chico) = super(chico).div(2)
}

class Necio inherits Adulto{
    override method seAsusta(chico) = false
}