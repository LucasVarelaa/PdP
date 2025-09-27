// src/manager.wlk
// src/manager.wlk
import menu.*
import flappy.*
import obstaculos.*
import powerUps.*

object gameManager{

  method empezar(){
    game.addVisual(flappyLei)
    // Caída de flappylei
    game.onTick(1000,"movimiento",{flappyLei.bajar()})

    game.onTick(500,'obstaculos movement',{obstaculosManager.moverIzquierda()})

    game.onTick(8000,'Power up render',{powerUp.render()})
    game.onTick(500,'Power up movimiento',{powerUp.moverIzquierda()})
    
    // manejo de colisiones
    game.onCollideDo(flappyLei, {cosa => cosa.reaccionar()})

    // Visuales adicionales
    game.addVisual(pisoInvisible)
    game.addVisual(techoInvisible)
    game.addVisual(score)
    game.addVisual(flappyLei)


  }
}