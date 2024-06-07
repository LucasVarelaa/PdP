-- tipo de dato   constructor
data Nomus = UnNomus{
    alas :: Bool,
    brazos :: Int,
    ojos :: Int,
    piel :: String,
    vida::Float,
    fuerza::Float
}

puedeVer :: Nomus -> Bool
puedeVer nomus = cantOjos nomus > 0

cantOjos :: Nomus -> Int
cantOjos(UnNomus _ _ ojos _ _ _)=ojos

categoria :: Float -> String
categoria fuercita
    |fuercita > 10000 = "high-end"
    |fuercita > 3000 = "fuerte"
    |fuercita > 1000 = "comun"
    |otherwise = "pichi"

fuercita :: Nomus -> Float
fuercita(UnNomus _ _ _ _ _ fuerza)=fuerza