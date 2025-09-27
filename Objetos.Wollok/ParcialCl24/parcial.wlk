// https://docs.google.com/document/d/1lP48bZ8y-K3x-1-o6dhxOOQzWKyMoP8Pqajh56LdAzc/edit?tab=t.0#heading=h.1w6qyv2n0qy9

// ---------------------------------------------------------------------------------------------------------------------
// CONTENIDOS
// ---------------------------------------------------------------------------------------------------------------------

// // property repaso (monetizacion)
//     method monetizacion(valor) {monetizacion = valor} // setter mensaje que lo pisa
//     method monetizacion() = monetizacion // getter mensaje que lo lee

class Contenido{
    const property titulo
    var property vistas = 0
    var property ofensivo = false
    var property monetizacion  

    // redeclaro el setter para verificar que es correcto la monetizacion que le pasen
    method monetizacion(nuevaMonetizacion) {
        if(!monetizacion.puedeAplicarseA(self)) {
            throw new DomainException(message = "Este contenido no soporta la forma de monetizacion")
    }
        monetizacion = nuevaMonetizacion
    }

    method recaudacion() = monetizacion.recaudacionDe(self)
    method puedeVenderse() = self.esPopular() // CADA SUBCLASE DECIDE SI SE PUEDE VENDER DEPENDIENDO SU METHOD esPopular()
    
    method esPopular() // No tiene implementacion pero obligo a mis subclases a implementarla
    method recaudacionMaximaParaPublicidad() // NO ES NECESARIO PONERLO EN LA SUPERCLASE PERO ES BUENA PRACTICA

}

class Video inherits Contenido{
    override method esPopular() = vistas > 1000
    override method recaudacionMaximaParaPublicidad() = 10000
}

const tagsDeModa = ["objetos", "pdp", "serPeladoHoy"]
class Imagen inherits Contenido{
    const property tags = []

    override method esPopular() = tagsDeModa.all{ tag => tags.contains(tag) }
    override method recaudacionMaximaParaPublicidad() = 4000

}

// ---------------------------------------------------------------------------------------------------------------------
// MONETIZACIONES
// ---------------------------------------------------------------------------------------------------------------------

object publicidad { // Object porque en los otros voy a necesitar manipular un estado interno por cada Donacion/Descarga
    method recaudacionDe(contenido) = (
        0.05 * contenido.vistas() + 
        if(contenido.esPopular()) 2000 else 0
    ).min(contenido.recaudacionMaximaParaPublicidad())

    method puedeAplicarseA(contenido) = !contenido.ofensivo()
}

class Donacion {
    var property donaciones = 0
 
    method recaudacionDe(contenido) = donaciones

    method puedeAplicarseA(contenido) = true
}

class Descarga{
    const property precio 

    method recaudacionDe(contenido) = contenido.vistas() * precio

    method puedeAplicarseA(contenido) = contenido.puedeVenderse()
}

// ---------------------------------------------------------------------------------------------------------------------
// USUARIOS
// ---------------------------------------------------------------------------------------------------------------------


object usuarios {
  const todosLosUsuarios = []

  method emailsDeUsuariosRicos() = todosLosUsuarios
  .filter{ usuario => usuario.verificado()}
  .sortBy{ uno, otro => uno.saldoTotal() > otro.saldoTotal()} 
  .take(100)
  .map{usuarios => usuarios.email()}

  // de todos los usuarios quiero los mails de los verificados, ordenados por saldo total, y los primeros 100 usuarios

  method cantidadDeSuperUsuarios() = todosLosUsuarios.count{ usuario => usuario.esSuperUsuario() }
  //La función esSuperUsuario devuelve true si el objeto usuario tiene permisos de superusuario y false en caso contrario.

}

class Usuario{
    const property nombre 
    const property email
    var property verificado = false
    const contenidos = [] 

    method saldoTotal() = contenidos.sum{ contenido => contenido.recaudacion()}

    method esSuperUsuario() = contenidos.count{ contenido => contenido.esPopular() } >= 10

    method publicar(contenido){
        contenidos.add(contenido)
    }
}
