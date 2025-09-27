# **FlappyLei**

## **Equipo de desarrollo**

- **Lucas Varela**
- **Nehuen Regueira**
- **Franco Benedetti**
- **Geronimo Becker**

---

## **Capturas de Pantalla**

### **Personaje Principal: Milei**
![image](https://github.com/user-attachments/assets/4b88701b-3db3-4b36-90f9-508ba1f803fe)

### **Obstáculo**
![Obstáculo](https://github.com/user-attachments/assets/d002dacb-ae8a-4cf1-bf68-0fe095c14813)

### **Fondo del Juego**
![Fondo](https://github.com/user-attachments/assets/eb500857-81db-46d8-90e6-50cf5d761e37)

---

## Características del Juego

### Obstáculos
- Los obstáculos aparecen de manera constante y cambian de altura de forma aleatoria.
- Se mueven hacia la izquierda y, al llegar al borde izquierdo de la pantalla, su posición se reinicia hacia la derecha con una nueva altura aleatoria.
- Los obstáculos están compuestos de varias partes (subobstáculos).
- **Colisión**: Si Milei colisiona con algún obstáculo, el juego finaliza.

### Power-Ups
Los **power-ups** añaden efectos especiales al juego. Actualmente, incluyen:

1. **Lali Espósito**
   - **Efecto**: Disminuye la puntuación en 3 puntos y reproduce una canción específica (`fanatico.mp3`) al activarse.
   - **Ubicación Aleatoria**: Se genera en una posición aleatoria en el eje Y, y se mueve hacia la izquierda hasta salir de la pantalla.

2. **Banco Central**
   - **Efecto**: Invierte los controles de Milei durante 6 segundos, haciendo que el jugador deba adaptarse rápidamente para evitar colisiones.
   - **Ubicación Aleatoria**: Similar al power-up de Lali, aparece en una posición aleatoria y se mueve hacia la izquierda.

> Los power-ups son gestionados por el objeto `powerUp`, que selecciona aleatoriamente entre los power-ups disponibles y los coloca en la pantalla. Cuando un power-up se sale de la pantalla o es activado, se elimina del juego.

### Puntuación
- Cada vez que Milei pasa con éxito entre los obstáculos, la puntuación aumenta en 1.
- La puntuación se muestra en pantalla y puede disminuir si Milei activa ciertos power-ups, como el de Lali.

---

## **Otros**

- **Curso: k2005/UTNfrba**
- **Versión de Wollok: 0.2.7**
- Queremos mantener el repo Privado

---

