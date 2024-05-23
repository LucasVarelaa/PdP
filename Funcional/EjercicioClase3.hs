-- Rambo tiene dos armas, una principal y una secundaria, cada uno con un cargador con cierta cantBalas
-- 1 averiguar cuantas balas le quedan en total
-- 2 dada un arma disparar si tiene balas
-- 3 hacer que rango dispare todas las armas a la vez

data Arma = Arma {
    balas :: Int,
    tamCargador ::  Int
} deriving (Eq, Show) -- define las dos funciones automaticamente 

data Rambo = Rambo {
    armaPrincipal :: Arma,
    armaSecundaria :: Arma
} deriving (Eq, Show)

balasTotales :: Rambo -> Int
-- balasTotales (Rambo (Arma balasP _) (Arma balasS _)) = balasP + balasS
balasTotales rambo = balas (armaPrincipal rambo) + balas (armaSecundaria rambo)

disparar :: Arma -> Arma
disparar arma | balas arma == tamCargador arma = arma{balas = balas arma - 2}
              | balas arma > 0                 = arma{balas = balas arma - 1}
              | otherwise                      = arma

dispararTodo :: Rambo -> Rambo
dispararTodo rambo = rambo {
    armaPrincipal = disparar (armaPrincipal rambo),
    armaSecundaria = disparar (armaSecundaria rambo)
}

-- -- Crear un Rambo con dos armas, cada una con algunas balas
-- let rambo = Rambo {armaPrincipal = Arma {balas = 5, tamCargador = 10}, armaSecundaria = Arma {balas = 8, tamCargador = 10}}

-- -- Mostrar el estado inicial de Rambo
-- print rambo

-- -- Disparar todas las armas
-- let ramboDespues = dispararTodo rambo

-- -- Mostrar el estado de Rambo después de disparar
-- print ramboDespues
