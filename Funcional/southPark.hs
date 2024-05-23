-- Definición de tipos de datos
data Personaje = Personaje
    { nombre :: String
    , dinero :: Int
    , felicidad :: Int
    } deriving Show

data Actividad = Escuela
               | CheesyPoofs Int
               | Trabajo String
               | DobleTurno String
               | WoW Int Int
               | OtraActividad (Personaje -> Personaje)

-- Función para aplicar una actividad a un personaje
aplicarActividad :: Personaje -> Actividad -> Personaje
aplicarActividad p Escuela
    | nombre p == "Butters" = p { felicidad = felicidad p + 20 }
    | otherwise = p { felicidad = felicidad p - 20 }
aplicarActividad p (CheesyPoofs n) = p { felicidad = felicidad p + 10, dinero = dinero p - 10 * n }
aplicarActividad p (Trabajo t) = p { dinero = dinero p + length t }
aplicarActividad p (DobleTurno t) = p { felicidad = felicidad p - length t * 2 }
aplicarActividad p (WoW amigos horas)
    | horas <= 5 = p { felicidad = felicidad p + amigos * 10, dinero = dinero p - 10 * horas }
    | otherwise = p { dinero = dinero p - 10 * horas }
aplicarActividad p (OtraActividad f) = f p

----

-- ghci> aplicarActividad (Personaje "lolo" 10 20) Escuela

-- ghci> aplicarActividad stan (CheesyPoofs 5)
-- Personaje {nombre = "Stan", dinero = 445, felicidad = 60}
-- ghci> stan
-- Personaje {nombre = "Stan", dinero = 495, felicidad = 50}

---- Comienzo parte 2

repetirActividad :: Personaje -> Actividad -> Int -> Personaje
repetirActividad personaje _ 0 = personaje
repetirActividad personaje act cant = repetirActividad (aplicarActividad personaje act) act (cant - 1)

-- ghci> stan
-- Personaje {nombre = "Stan", dinero = 100, felicidad = 50}
-- ghci> aplicarActividad stan (Trabajo "Mafia")
-- Personaje {nombre = "Stan", dinero = 105, felicidad = 50}
-- ghci> repetirActividad stan (Trabajo "Mafia") 5
-- Personaje {nombre = "Stan", dinero = 125, felicidad = 50}


aplicarTodasLasListasActividadades :: Personaje -> [Actividad] -> Personaje
aplicarTodasLasListasActividadades personaje [] = personaje
aplicarTodasLasListasActividadades personaje (act:resto) = aplicarTodasLasListasActividadades (aplicarActividad personaje act) resto
-- Cuando usamos el patrón act:resto, estamos desestructurando la lista de actividades en dos partes:
-- act: representa el primer elemento de la lista.
-- resto: representa el resto de la lista (todos los elementos después del primero).

--
-- ghci> aplicarTodasLasListasActividadades stan [Escuela, Escuela, CheesyPoofs 2] 
-- Personaje {nombre = "Stan", dinero = 80, felicidad = 20}
--

-- LOGROS
esMillonario :: Personaje -> Bool
esMillonario personaje = dinero personaje >= dinero ericCartman

estarContento :: Int -> Personaje -> Bool
estarContento nivelDeseado personaje = felicidad personaje > nivelDeseado

irATerranceYPhillip :: Personaje -> Bool
irATerranceYPhillip personaje = dinero personaje >= 10

copado :: Personaje -> Bool
copado personaje = dinero personaje >= 50 && felicidad personaje >= 50

-- data Logro = EsMillonario
--            | EstarContento Int
--            | IrATerranceYPhillip
--            | Copado

-- cumpleLogro :: Logro -> Personaje -> Bool
-- cumpleLogro EsMillonario personaje = dinero personaje >= dinero ericCartman
-- cumpleLogro (EstarContento nivelDeseado) personaje = felicidad personaje > nivelDeseado
-- cumpleLogro IrATerranceYPhillip personaje = dinero personaje >= 10
-- cumpleLogro Copado personaje = dinero personaje >= 50 && felicidad personaje >= 50


actividadDecisiva :: Personaje -> Actividad -> Bool
actividadDecisiva personaje act = not (cumpleLogro personaje) && cumpleLogro (aplicarActividad personaje act)
    where
        cumpleLogro = esMillonario   
-- Como ambos tienen que ser TRUE si el negativo de cumpleLogro, sin aplicar actividad, se cumple y aplicar actividad se cumple entonces verifica que es significativo

-- actividadDecisiva :: [Personaje] -> Logro -> Actividad -> Boolss
-- actividadDecisiva personaje logro actividad = 
--     not (cumpleLogro personaje logro) && cumpleLogro (personaje )
--   where
--     cumpleLogro = esMillonario
--     aplicarActividad


-- CON COMPOSICION


-- Ejemplo de uso
stan :: Personaje
stan = Personaje "Stan" 495 50

butters :: Personaje
butters = Personaje "Butters" 50 70

ericCartman :: Personaje
ericCartman = Personaje "Eric" 500 15

-- Actividades
irAEscuela :: Actividad
irAEscuela = Escuela

comerCheesyPoofs :: Int -> Actividad
comerCheesyPoofs n = CheesyPoofs n

trabajar :: String -> Actividad
trabajar t = Trabajo t

dobleTurno :: String -> Actividad
dobleTurno t = DobleTurno t

jugarWoW :: Int -> Int -> Actividad
jugarWoW amigos horas = WoW amigos horas

otraActividad :: (Personaje -> Personaje) -> Actividad
otraActividad f = OtraActividad f


-- Definición de una actividad inventada
aumentarFelicidad :: Int -> Actividad
aumentarFelicidad n = otraActividad (\p -> p { felicidad = felicidad p + n })