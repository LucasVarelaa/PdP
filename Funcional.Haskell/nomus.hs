--   Tipo  = Constructor
data Nomus = UnNomus {
    alas :: Bool,
    cantBrazos :: Int,
    cantOjos :: Int,
    piel :: String,
    vida :: Float,
    fuerza :: Float
} deriving (Eq, Show)

-- declaro las funciones con deriving...
--fuerza(UnNomus _ _ _ _ _ fuerza) = fuerza

categoria :: Nomus -> String
categoria nomus
    | f > 10000 = "High-End"
    | f > 3000 = "Fuertes"
    | f > 1000 = "Comun"
    | otherwise =  "Pichi"
    where f = fuerza nomus -- Cambiar la variable dentro

puedeVer :: Nomus -> Bool
puedeVer nomus = cantOjos nomus > 0

-- Declarar un nomu
nomu1 :: Nomus
nomu1 = UnNomus True 3 0 "morocha" 888 20
--ghci> fuerza nomu1 -- le pregunto la fuerza -- 20

--ghci> puedeVer (UnNomus True 3 0 "morocha" 888 20)
--ghci> alas (UnNomus True 3 0 "morocha" 888 20) -- Como alas es una funcion le preguntas en este casi si es que tiene o no -- True

-- UnNomus es la etiqueta para crear un nomu
entrenar :: Float -> Nomus -> Nomus
entrenar tiempo nomus = UnNomus{
    cantOjos = cantOjos nomus,
    cantBrazos = cantBrazos nomus,
    alas = alas nomus,
    fuerza = fuerza nomus + tiempo,
    vida = vida nomus,
    piel = piel nomus
}
-- ghci> fuerza (entrenar 20 nomu1)
-- ghci> fuerza (entrenar 30 (entrenar 50 nomu1))
-- ghci> entrenar 10 nomu1
-- UnNomus {alas = True, cantBrazos = 3, cantOjos = 0, piel = "morocha", vida = 888.0, fuerza = 30.0}

-- OTRA FORMA DE ACORTARLO, no tiene un nombre el nuevo nomu
-- entrenar tiempo nomu = nomu{
--     fuerza = fuerza nomu + tiempo
-- } 
-- ghci> (entrenar 10 nomu1)
-- ghci> entrenar 50 (entrenar 10 nomu1)

-- LAS FUNCIONES NO VARIAN


potencia :: Nomus -> Float
potencia (UnNomus _ _ _ "morocha" _ _) = 0

potencia (UnNomus _ _ _ _ vida fuerza) = fuerza + vida

potencia2 :: Nomus -> Float
potencia2 nomus = fuerza nomus + vida nomus
--ghci> potencia2 nomu1