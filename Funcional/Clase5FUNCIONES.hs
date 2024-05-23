data Carta = Carta {
    nombre :: String,
    tags :: [String],
    velocidad :: Int,
    altura :: Int,
    peso :: Int,
    fuerza :: Int,
    peleas :: Int
} deriving (Show)

-- Definición de datos de ejemplo
flash :: Carta
flash = Carta
    { nombre = "Flash"
    , tags = ["Velocidad", "Rapido", "Superheroe"]
    , velocidad = 100
    , altura = 185
    , peso = 70
    , fuerza = 20
    , peleas = 90
    }

superman :: Carta
superman = Carta
    { nombre = "Superman"
    , tags = ["Fuerza", "Vuelo", "Alguien", "Superheroe"]
    , velocidad = 80
    , altura = 191
    , peso = 101
    , fuerza = 100
    , peleas = 95
    }

spiderman :: Carta
spiderman = Carta
    { nombre = "Spider-Man"
    , tags = ["Agilidad", "Telarañas", "Superheroe"]
    , velocidad = 60
    , altura = 178
    , peso = 76
    , fuerza = 50
    , peleas = 0
    }

batman :: Carta
batman = Carta
    { nombre = "Batman"
    , tags = ["Inteligencia", "Tecnologia", "Superheroe"]
    , velocidad = 50
    , altura = 188
    , peso = 95
    , fuerza = 70
    , peleas = 85
    }

wonderWoman :: Carta
wonderWoman = Carta
    { nombre = "Wonder Woman"
    , tags = ["Fuerza", "Lazo", "Superheroe"]
    , velocidad = 70
    , altura = 180
    , peso = 72
    , fuerza = 90
    , peleas = 95
    }

todas :: [Carta]
todas = [flash, superman, spiderman, batman, wonderWoman]

ganadorSegun :: (Carta -> Int) -> Carta -> Carta -> Carta
ganadorSegun criterio carta1 carta2 |  criterio carta1 > criterio carta2 = carta1
                                    |  otherwise = carta2

ganadorSegunIMC :: Carta -> Carta -> Carta
ganadorSegunIMC = ganadorSegun (\carta -> peso carta `div` altura carta ^ 2) --carta1 carta2       y carta1 carta2 antes del = tambien

--Quiero el nombre de cada Carta
nombres :: [Carta] -> [String]
nombres = map nombre --cartas      y cartas anntes del =

--Quiero la fuerza de cada Carta
fuerzas :: [Carta] -> [Int]
fuerzas = map fuerza --cartas      y cartas antes del =

--Quiero la longitud del nombre de cada carta
longitudDelNombre :: [Carta] -> [Int]
longitudDelNombre = map (length.nombre) --cartas     y cartas antes del =

--Quiero saber las cartas de superHeroes nuevos (no tienen peleas)
nuevos :: [Carta] -> [Carta]
nuevos = filter ((==0) . peleas) --cartas      y cartas antes del =

--Quiero las cartas cuyos nombres tienen 'o'
conO :: [Carta] -> [Carta]
conO = filter (elem 'o'. nombre)

--Quiero las cartas con mas pero que altura
pesadas :: [Carta] -> [Carta]
pesadas = filter (\cart -> peso cart + 100 > altura cart)  --cartas     y cartas antes del =

--Quiero saber si HAY cartas de superHeroes nueos
hayNuevos :: [Carta] -> Bool
hayNuevos = any ((==0) . peleas)--cartas     y cartas antes del =

--Quiero saber si TODOS los nombres tienen 'o'
todosConO :: [Carta] -> Bool
todosConO = all (elem 'o'. nombre)--cartas     y cartas antes del =

--Quiero saber si EXISTEN cartas con mas peso que altura
hayPesadas :: [Carta] -> Bool
hayPesadas = any (\cart -> peso cart + 100 > altura cart)--cartas     y cartas antes del =

--Quiero saber el total de peleas ganadas
peleasTotales :: [Carta] -> Int
peleasTotales cartas = foldr (\cart acum -> acum + peleas cart) 0 cartas
peleasTotales2 :: [Carta] -> Int
peleasTotales2 cartas = sum (map peleas cartas) -- O (sum . map peleas)

--Quiero todos los nombres en un string intercalados con ;
nombresSeparados :: [Carta] -> String
nombresSeparados = foldr (\cart acum -> nombre cart ++ " ; " ++ acum) "" --cartas     y cartas antes del = -- (+ suma, ++ agraga)
nombresSeparados2 :: [Carta] -> String
nombresSeparados2 = (concat.map ((++ " ; ").nombre))

--Quiero la carta que tenga la mayor fuerza
masFuerte :: [Carta] -> Carta
masFuerte cartas = foldr (ganadorSegun fuerza) (head cartas) (tail cartas) --La función tail en Haskell toma una lista y devuelve
--una lista que contiene todos los elementos excepto el primero. Es decir, elimina el primer elemento de la lista y devuelve el resto de la lista
-- FOLDR1 DIRECTAMENTE TOMA COMO RAIZ LA CABEZA DE LA LISTA Y ELIMINA ESE PRIMER ELEMENTO SI SIGUE
-- masFuerte = foldr1 (ganadorSegun fuerza)

-- Otras funciones son maximum, minimum, concat, sum, length, tail, head, null, elem, estaOrdenada, INIT (tags carta) -- saca el ultimo elemento de la lista

ponerTag :: String -> Carta -> Carta
ponerTag tag carta = carta{tags = tag : tags carta} 
ponerTag2 :: String -> Carta -> Carta
ponerTag2 tag carta = carta{
    tags = tags carta ++ [tag]}
-- Como cabeza de la lista ponemos el nuevo tag y como cola ponemos los tags actuales de la carta
--  LISTAS --
--      { []   -- Nill :: [a]  LISTA VACIA
--   [a]{
--      { (:)  -- Cons :: a -> [a]
--                   cabeza -> cola 
-- 1 : (2 : 3 : [])      ----  [1, 2, 3] 

quitarTag :: String -> Carta -> Carta
quitarTag tag carta = carta{tags = filter (/= tag) (tags carta)} 
-- Crea una copia de la carta a la que tenia excepto al tag que queremos sacar
-- Le pasamos como predicado la negacion de tag que devuelve true si no es el tag y le pasamos la lista de tags
-- Entones filtra los true, aquellos que no son iguales a tag y arma una lista con los que son distintos a este

quitarUltimoTag :: Carta -> Carta
quitarUltimoTag carta = carta {tags = init (tags carta)}

batiNombres :: [Carta] -> [String]
batiNombres cartas = (filter ((== "bat") . take 3) . map (nombre)) cartas

hayCartasConTodosTagsLargos :: [Carta] -> Bool
hayCartasConTodosTagsLargos cartas = (any (all ((>=10) . length) . tags)) cartas

aliensCorregidos :: [Carta] -> [Carta]
aliensCorregidos cartas = (map (ponerTag "Alien". quitarTag "Alguien") . filter (elem "Alguien" . tags)) cartas
--                         ([cartas] corregidas                        . [cartas] con tag erroneo      ) [cartas]
-- encontrar cartas mal impresas -- filter
-- corregir cada carta -- map

-------------------------- Extras ------------------------------
-- numero entre 1 y 5
between n m x = elem x [n .. m]

-- superaLaguna :: PasaObstaculo
-- superaLaguna tiro = velocidad tiro > 80 && between 1 5 (altura tiro)



maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b