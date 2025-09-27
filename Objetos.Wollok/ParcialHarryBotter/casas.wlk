import a.*

object gryffindor {
  var property esPeligrosa = false
}

object slytherin {
  var property esPeligrosa = true
}

object ravenclaw {
    var estudiantes = []
    
    method esPeligrosa() = estudiantes.cantEstudiantesPuros() > estudiantes.cantEstudiantesSucios()
}

object hufflepuff {
    var estudiantes = []

    method esPeligrosa() = estudiantes.cantEstudiantesPuros() > estudiantes.cantEstudiantesSucios()
}