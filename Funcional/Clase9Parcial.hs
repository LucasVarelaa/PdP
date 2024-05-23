-- https://docs.google.com/document/u/0/d/e/2PACX-1vQNqVQl8zhWL3kiviJYzw87_SQfjmWvrvuOhH1wSDJj4TAm3fkifzgiwrrdSRsIcqodQB0pZJRTh1__/pub?pli=1

type Peso = Int
type Tiempo = Int
type Grados = Int
type Ejercicio = Tiempo -> Gimnasta -> Gimnasta

data Gimnasta = Gimnasta {
    pesoGimnasta :: Int,
    tonificacion :: Int
} deriving Show

data Rutina = Rutina {
 nombre :: String,
 duracionTotal :: Tiempo,
 ejercicios :: [Ejercicio]
}

-- 1 operaciones

tonificar :: Int -> Gimnasta -> Gimnasta
tonificar tonific gimnasta = gimnasta{tonificacion = tonificacion gimnasta + tonific}

quemarCalorias :: Int -> Gimnasta -> Gimnasta
quemarCalorias caloria gimnasta = gimnasta{pesoGimnasta = pesoGimnasta gimnasta - caloria `div` 500}

-- 2 ejercicios

cinta :: Tiempo -> Int -> Gimnasta -> Gimnasta
cinta tiempo velocidadPromedio   = quemarCalorias (tiempo * 10 * velocidadPromedio)

caminata :: Tiempo -> Gimnasta -> Gimnasta
caminata = cinta 5 -- tiempo gimnasta

pique :: Tiempo -> Gimnasta -> Gimnasta
pique tiempo  = cinta (tiempo `div` 2 + 20) tiempo --gimnasta

pesas :: Tiempo -> Peso -> Gimnasta -> Gimnasta
pesas tiempo peso gimnasta                     -- Usamos guardas
    | tiempo < 10 = gimnasta
    | otherwise = tonificar peso gimnasta

colina :: Tiempo -> Int -> Gimnasta -> Gimnasta
colina tiempo inclinacion  = quemarCalorias (2 * tiempo * inclinacion)-- gimnasta

montania :: Tiempo -> Int -> Gimnasta -> Gimnasta
montania tiempo inclinacion  =
    tonificar 3 . colina tiempito (inclinacion + 5) . colina tiempito inclinacion -- (gimnasta)
    where tiempito = tiempo `div` 2

montania2 :: Tiempo -> Int -> Gimnasta -> Gimnasta
montania2 tiempo inclinacion  =
    let tiempito = tiempo `div` 2
    in tonificar 3 . colina tiempito (inclinacion + 5) . colina tiempito inclinacion

-- 3

realizarRutina :: Gimnasta -> Rutina -> Gimnasta
realizarRutina gimnastaInicial rutina  =
    foldl (\gimnasta ejercicio -> ejercicio tiempoEjercicio gimnasta) gimnastaInicial (ejercicios rutina)
--         gimnasta que viente realizando la rutina y ejercicio es el siguiente a hacer
    where tiempoEjercicio = (div (duracionTotal rutina) . length . ejercicios) rutina

-- con funcion externa
-- tiempoEjercicio :: Rutina -> Tiempo
-- tiempoEjercicio rutina = (div (duracionTotal rutina) . length . ejercicios) rutina
-- si hago eso tengo que pasarle (tiempoEjercicio rutina) 

realizarRutina2 :: Gimnasta -> Rutina -> Gimnasta
realizarRutina2 gimnastaInicial rutina  =
    let tiempoEjercicio = (div (duracionTotal rutina) . length . ejercicios) rutina
    in foldl (\gimnasta ejercicio -> ejercicio tiempoEjercicio gimnasta) gimnastaInicial (ejercicios rutina)

-- 4
mayorCantidadDeEjercicios :: [Rutina] -> Int
mayorCantidadDeEjercicios  = maximum . map (length . ejercicios)-- rutina
--                            maximo . lista de cantidades de rutina -- maximum obtiene una lista de elementos comparables y obtiene el maximo
-- map obtiene una funcion y una lista nosotros necesitamos que en cada ejercicio se aplique length

nombresDeRutinasTonificantes :: Gimnasta -> [Rutina] -> [String]
nombresDeRutinasTonificantes gimnasta  = map nombre . filter ( (> tonificacion gimnasta) . tonificacion . realizarRutina2 gimnasta ) --rutina

hayPeligrosa :: Gimnasta -> [Rutina] -> Bool
hayPeligrosa gimnasta = any ((< pesoGimnasta gimnasta `div` 2) . pesoGimnasta . realizarRutina gimnasta)
