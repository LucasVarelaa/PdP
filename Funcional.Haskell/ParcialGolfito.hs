import Data.IntMap.Merge.Lazy (preserveMissing)
import GHC.Generics (prec)
-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

-- 1 PALOS
type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro {velocidad = 10, precision = precisionJugador habilidad * 2, altura = 0}

madera :: Palo
madera habilidad = UnTiro {velocidad = 100, precision = precisionJugador habilidad `div` 2, altura = 5}

hierros :: Int -> Palo
hierros n habilidad ----- O altura = max (n-3) 0 -- para asegurarnos que si n-3 es negativo, se agarre el max, que es 0
    | n > 3 = UnTiro {velocidad = fuerzaJugador habilidad * n, precision = precisionJugador habilidad `div` n, altura = n-3}
    | otherwise = UnTiro {velocidad = fuerzaJugador habilidad * n, precision = precisionJugador habilidad `div` n, altura = 0}
-- `div` divide enteros mientras que / numeros flotantes

palos :: Int -> [Palo]
palos n = [putter, madera, hierros n]

-- 2 FUNCION GOLPE

golpe :: Jugador -> Palo -> Tiro
golpe jugador palo = palo (habilidad jugador)

-- 3 OBSTACULOS

data Obstaculo = UnObstaculo{
    tiroPostObstaculo :: Tiro -> Tiro,
    superaObstaculo :: Tiro -> Bool
}

type PostObstaculo = Tiro -> Tiro
type PasaObstaculo = Tiro -> Bool
tiroDetenido :: Tiro
tiroDetenido = UnTiro 0 0 0

-- tunel

superaTunelConRampita :: PasaObstaculo
superaTunelConRampita tiro = altura tiro == 0 && precision tiro > 90

postTunelConRampita :: PostObstaculo
postTunelConRampita tiro
  | superaTunelConRampita tiro = tiro {velocidad = velocidad tiro * 2, precision = 100, altura = 0}
  | otherwise = tiroDetenido

-- laguna

superaLaguna :: PasaObstaculo
superaLaguna tiro = velocidad tiro > 80 && between 1 5 (altura tiro)

postLaguna :: Int -> PostObstaculo
postLaguna largo tiro
    | superaLaguna tiro = tiro{velocidad = velocidad tiro, precision = precision tiro, altura = altura tiro `div` largo}
    | otherwise = tiroDetenido

-- hoyo

superaHoyo :: PasaObstaculo
superaHoyo tiro = between 5 20 (velocidad tiro) && altura tiro == 0 && precision tiro > 95

postHoyo :: PostObstaculo
postHoyo tiro = tiroDetenido

-- 4 

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles jugador obstaculo = filter (superaObstaculoConPalo jugador obstaculo) (palos 2) -- el 2 es por el tiepo de hierro

superaObstaculoConPalo :: Jugador -> Obstaculo -> Palo -> Bool
superaObstaculoConPalo jugador obstaculo palo = superaObstaculo obstaculo (golpe jugador palo)

obstaculosConsecutivosSuperados :: [Obstaculo] -> Tiro -> Int
obstaculosConsecutivosSuperados [] _ = 0
obstaculosConsecutivosSuperados (obs1:obsS) tiro -- obs1 el primer elemento de la lita -- obsS todo el resto de la lista
    | superaObstaculo obs1 tiro = 1 + obstaculosConsecutivosSuperados obsS (tiroPostObstaculo obs1 tiro)
    | otherwise = 0
    -- en cada funcion que se vuelva a llamar recursivamente, el tiro se va a ir modificando dada las condiciones 

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil jugador obstaculos = maximoSegun (obstaculosConsecutivosSuperados obstaculos . golpe jugador) (palos 2)


-- 5 
padresQuePerdieron :: [(Jugador,Puntos)] -> [String]
padresQuePerdieron lista = ((map (padre.fst)).niniosPerdedores) lista

niniosPerdedores :: [(Jugador,Puntos)] -> [(Jugador,Puntos)]
niniosPerdedores lista = filter ((/= ninioGanador lista).fst) lista

ninioGanador :: [(Jugador,Puntos)] -> Jugador
ninioGanador lista = fst (maximoSegun snd lista)

listaPuntos = [(bart,10),(todd,2),(rafa,15)]