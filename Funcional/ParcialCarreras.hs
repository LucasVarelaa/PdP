data Auto = UnAuto{
    color :: String,
    velocidad :: Int,
    distancia :: Int
} deriving (Show, Eq)

type Carrera = [Auto]

-- 1 COMO VA

estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = (color auto1 /= color auto2) && (abs (distancia auto1 - distancia auto2) < 10)

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = all (not . (estaCerca auto)) carrera && distancia auto == maximum (listaDistancias carrera)

listaDistancias :: [Auto] -> [Int]
listaDistancias = map distancia

puesto :: Auto -> Carrera -> Int
puesto auto carrera = (length . filter (not . leGana auto)) carrera + 1
--                  = 1 + (length filter (< distancia auto) . distancia)) carrera

leGana :: Auto -> Auto -> Bool
leGana auto1 auto2 = distancia auto1 < distancia auto2

-- 2 VELOCIDAD

correr :: Int -> Auto -> Auto
correr tiempo auto = auto{distancia = distancia auto + tiempo * velocidad auto}

alterarVelocidad :: (Int -> Int) -> Auto -> Auto
alterarVelocidad modificar auto = auto{velocidad = max 0 (modificar (velocidad auto))}

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad cant   = alterarVelocidad (\vel -> vel - cant) -- auto

-- 3 POWERS UPS
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista


terremoto :: Auto -> Carrera -> Carrera
terremoto auto  = afectarALosQueCumplen (estaCerca auto) (bajarVelocidad 50) -- carrera

miguelitos :: Int -> Auto -> Carrera -> Carrera
miguelitos cant auto  = afectarALosQueCumplen (leGana auto) (bajarVelocidad cant) -- carrera
--                                   (\a -> distancia a < distancia auto)

jetPack :: Int -> Auto -> Carrera -> Carrera
jetPack tiempo auto   = afectarALosQueCumplen (==auto) (cambiosJetpack tiempo) -- carrera

cambiosJetpack :: Int -> Auto -> Auto
cambiosJetpack tiempo auto = auto{distancia = distancia (correr tiempo (alterarVelocidad (*2) auto))}

-- 4  EVENTOS -- Tabla posiciones

simularCarrera :: Carrera -> [Carrera -> Carrera] -> [(Int, String)]
simularCarrera carrera eventos = obtenerPosiciones (aplicarListaEventos carrera eventos)

obtenerPosiciones :: Carrera -> [(Int, String)]
obtenerPosiciones carrera = map (\x -> (puesto x carrera,color x)) carrera

aplicarListaEventos :: Carrera -> [Carrera -> Carrera] -> Carrera
aplicarListaEventos carrera [] = carrera
aplicarListaEventos carrera (xi:xs) = aplicarListaEventos (xi carrera) xs
-- aplicarListaEventos carrera xs = foldl (\ carrera xi -> x carrera) carrera xs

correnTodos :: Int -> Carrera -> Carrera
correnTodos tiempo carrera = map (correr tiempo) carrera


type PowerUp = Auto -> Carrera -> Carrera

usarPowerUps :: PowerUp -> String -> Carrera -> Carrera
usarPowerUps powerUp colorBuscado carrera = powerUp (obtenerAutoPorColor colorBuscado carrera) carrera

obtenerAutoPorColor :: String -> Carrera -> Auto
obtenerAutoPorColor colorBuscado   = head . filter ((==colorBuscado) . color) --carrera