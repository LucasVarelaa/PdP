// src/obstaculos.wlk
import manager.*
import wollok.game.*
import flappy.*
import powerUps.*
import menu.*

class Morir {

    method reaccionar() {
        game.removeTickEvent("movimiento")
        game.removeTickEvent("obstaculos movement")
        game.removeTickEvent("powerUp")
        game.removeTickEvent("aparicion obstaculos")
        game.removeTickEvent("Power up render")
        game.removeTickEvent("Power up movimiento")
        game.removeTickEvent("cambiar invertido")
        game.removeTickEvent("Frenar cancion")

        obstaculosManager.resetPosition()
        //game.sound(lali.cancion()).stop()
        //game.sound(larreta.cancion()).stop()
        //game.sound(bancoCentral.cancion()).stop()
        //game.sound(dolar.cancion()).stop()
        powerUp.lista().forEach({p=>game.removeVisual(p)})
        
        
        if (powerUp.cancionSonando()){
            powerUp.cancionActual().stop()
            powerUp.terminaCancion() // Para setear el bool de cancion sonando en false
        }
        powerUp.vaciarLista()

        flappyLei.position(flappyLei.initialPosition())
        flappyLei.setInvertido(false)
        
        menu.render()
        score.text(0)

    }
}


const obs0 = new Obstaculo(xInicial= 17, yInicial = 0)
const obs1 = new Obstaculo(xInicial= 23, yInicial = -1)
const obs2 = new Obstaculo(xInicial= 29, yInicial = 1)
const obs3 = new Obstaculo(xInicial= 35, yInicial = 0)
class Obstaculo {
    const coleccionSubObstaculos = []
    
    method obtenerColeccionSubObstaculos() = coleccionSubObstaculos

    const xInicial
    const yInicial 

    var x = xInicial
    var y = yInicial 


    //Se corre solo al inicializar el juego
    method inicializar(){
        coleccionSubObstaculos.add(new SubObstaculo(p=game.at(xInicial, yInicial), image = "obsTechInv2.png",ordenSubObstaculo=7))
        coleccionSubObstaculos.add(new SubObstaculo(p=game.at(xInicial, yInicial), image = "obsTech2.png",ordenSubObstaculo=3))
        [-6,-5,-4,-3,-2,-1,0,1,2,8,9,10,11,12,13,14,15].forEach({sub => coleccionSubObstaculos.add(new SubObstaculo(p = game.at(xInicial, yInicial), image = "obstMedio2.png", ordenSubObstaculo = sub))})
        coleccionSubObstaculos.forEach({ sub => game.addVisual(sub)})
        self.resetPosition()
    }

    method resetPosition() {
        coleccionSubObstaculos.forEach({ sub => sub.position(xInicial,yInicial + sub.ordenSubObstaculo()) })
        x = xInicial
        y = yInicial 
    }

    //Mueve periodicamente los objetos hacia la izquierda hasta salir de pantalla, donde se mueven
    method moverIzquierda(){
        coleccionSubObstaculos.forEach({ sub => sub.moverIzquierda(1) })
        x = x-1
        if (x<=-4){
            x = 20
            self.cambiarAltura()
        }
        if (x==2){
             score.text(score.textNumero()+1)
        }
    }
    method cambiarAltura(){
        y = [-2,-1,0,1,2].anyOne() // Cambiar de altura de forma aleatoria
        coleccionSubObstaculos.forEach({ sub => sub.position(20,y + sub.ordenSubObstaculo()) })

    }
}

class SubObstaculo inherits Morir{
    var property p
    var property image
    const ordenSubObstaculo

    method position() = p
    method position(newPosition) { p = newPosition }
    method position(x,y) { p = game.at(x,y)}
    
    method image() = image

    method ordenSubObstaculo() = ordenSubObstaculo
    method moverIzquierda(c){
        p = p.left(c)
    }
    method moverDerecha(c){
        p = p.right(c)
    }
    method cambiarAltura(c){
        p = p.up(c)
    }
    
}

object obstaculosManager {
     const coleccionObstaculos = [obs0,obs1,obs2,obs3]

    method obtenerColeccionObstaculos() = coleccionObstaculos
    
    //Metodo que inicializa y renderiza los obstaculos al iniciar el programa
    method inicializar() {
        coleccionObstaculos.forEach({ obs => obs.inicializar() })
    }
    //Resetea la posicion de todos los obstaculos a fuera de la pantalla
    method resetPosition() {
        coleccionObstaculos.forEach({ obs => obs.resetPosition() })
    }
    //Mueve periodicamente los objetos hacia la izquierda hasta salir de pantalla, donde se mueven
    method moverIzquierda(){
        coleccionObstaculos.forEach({ obs => obs.moverIzquierda() })
    }
    
}


