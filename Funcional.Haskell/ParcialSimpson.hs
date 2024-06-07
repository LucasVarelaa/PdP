data Personaje = UnPersonaje {
    nombre :: String,
    dinero :: Int,
    felicidad :: Int
} deriving Show

-- 1 ACTIVIADES PERSONAJES

type Actividad = Personaje -> Personaje

irEscuela :: Actividad
irEscuela personaje
    | nombre personaje == "lisa" = personaje{felicidad = felicidad personaje + 20}
    | otherwise = personaje{felicidad = felicidad personaje - 20}

comerDonas :: Int -> Actividad
comerDonas cant personaje = personaje{felicidad = felicidad personaje + cant * 10, dinero = dinero personaje - 10 * cant}

irTrabajo :: String -> Actividad
irTrabajo trabajo personaje
    | trabajo == "escuela elemental" = personaje{dinero = dinero personaje + length trabajo, felicidad = felicidad personaje - 20}
    | otherwise = personaje{dinero = dinero personaje + length trabajo}

jugarBolos :: Int -> Actividad
jugarBolos horas personaje = personaje{felicidad = felicidad personaje + 10 * horas, dinero = dinero personaje - 10 * horas}

-- MODELAR PERSONAJES 

homero :: Personaje
homero = UnPersonaje{nombre = "homero", felicidad = 20, dinero = 600}

-- ghci> comerDonas 12 homero
-- UnPersonaje {nombre = "homero", dinero = 480, felicidad = 140}

skinner :: Personaje
skinner = UnPersonaje{nombre = "skinner", felicidad = 50, dinero = 150}

-- ghci> irTrabajo "escuela elemental" skinner
-- UnPersonaje {nombre = "skinner", dinero = 167, felicidad = 30}

lisa :: Personaje
lisa = UnPersonaje{nombre = "lisa", felicidad = 900, dinero = 10}

-- ghci> irEscuela lisa
-- UnPersonaje {nombre = "lisa", dinero = 10, felicidad = 920}

-- 2 LOGROS

type Logro = Personaje -> Bool

burns :: Personaje
burns = UnPersonaje{nombre = "burns", felicidad = 50, dinero = 1000}

serMillonario :: Logro
serMillonario personaje = dinero personaje > dinero burns

alegrarse :: Int -> Logro
alegrarse felicidadDeseada personaje = felicidad personaje > felicidadDeseada

verKrosti :: Logro
verKrosti personaje = dinero personaje >= 10

serFamoso :: Logro
serFamoso personaje = nombre personaje == "krosti"

-- A

bart = UnPersonaje{dinero = 6, felicidad = 80, nombre = "bart"}

actividadDecisiva :: Actividad -> Logro -> Personaje -> Bool
actividadDecisiva actividad logro personaje = not (logro personaje) && logro (actividad personaje)
--                                                                     (logro . actividad) personaje
-- Ejemplos de consulta: 
-- actividadDecisiva (irTrabajo "mafia") verKrosti bart 
-- True
-- actividadDecisiva (irTrabajo "planta nuclear") serMillonario homero 
-- False

-- B

primerActividadDecisiva :: Personaje -> Logro -> [Actividad] -> Personaje
primerActividadDecisiva personaje _ [] = personaje
primerActividadDecisiva personaje logro (xi:xs)
    | actividadDecisiva xi logro personaje = xi personaje
    | otherwise = primerActividadDecisiva personaje logro xs

-- C

infinitasActividades :: [Actividad]
infinitasActividades = irEscuela:infinitasActividades 

-- Ejemplos de consulta:
-- primeraActividadDecisiva lisa (alegrarse 105) listaInfinitaActividades 
-- Personaje {nombre = "Lisa", dinero = 100, felicidad = 120}
-- Por evaluación diferida, encuentra la primera que es decisiva y la aplica
-- primeraActividadDecisiva bart irAVerAKrosty listaInfinitaActividades 
-- Hasta el momento no encontró ninguna decisiva, por lo que no dio ninguna respuesta, pero sigue buscando...

-- La evaluación perezosa permite que las listas infinitas sean tratadas como listas finitas, 
-- evaluando solo los elementos necesarios.
-- Esto significa que aunque la lista de actividades es infinita,
-- Haskell solo evalúa hasta el primer punto en el que la condición actividadDecisiva se cumple.
--aaaaaaaaa