import a.*
import casas.*

object inmobilus {
  method cumpleRequisitos(bot) = true

  method efectoHechizo(bot) {
      bot.disminuirCargaElectrica(50)
  }
}

object sectumSempra {

  method cumpleRequisitos(bot) = bot.esExperimentado()

  method efectoHechizo(bot) {
    if(bot.aceitePuro()) {
        bot.volversucio()
    }
  }
}

object avedakedabra {
  method cumpleRequisitos(bot) = !bot.aceitePuro() || howarts.casasPeligrosas().contains(bot.casa())

  method efectoHechizo(bot) {
        bot.anularCargaElectrica()
  }
  
}

class Comun{
    var cargaElectrica

    method cumpleRequisitos(bot) = bot.cargaElectrica() > cargaElectrica

    method efectoHechizo(bot) {
        bot.disminuirCargaElectrica(cargaElectrica)
    }
}

object lebiosa{
    method cumpleRequisitos(bot) = bot.casa().esPeligrosa() && bot.esExperimentado()

    method efectoHechizo(bot) {
        bot.anularCargaElectrica()
        bot.volversucio()
    }
}