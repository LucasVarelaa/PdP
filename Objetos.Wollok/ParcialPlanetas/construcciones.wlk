class Muralla  {
    const longitud

    method valor() = longitud * 10
}

class Museo {
    const superficie
    const importancia

    method valor() = superficie * importancia
}

object montania {
    method queConstruir(persona,duracion) = new Muralla(longitud=duracion/2)
}

object costa {
    method queConstruir(persona,duracion) = new Museo(superficie=duracion, importancia=1)
}

object llanura{
    method queConstruir(persona,duracion) {
        if(persona.esDestacada()) {
            new Museo(superficie=duracion, importancia = self.proporcional(persona.recursos()))
        }
        else {
            new Muralla(longitud=duracion/2)
        }
    }
    
    method proporcional(monto) = (monto / 100).floor().min(1).max(5) 
}

object mar {
    method queConstruir(persona,duracion) = new Museo(superficie=duracion, importancia=persona.inteligencia())
}
