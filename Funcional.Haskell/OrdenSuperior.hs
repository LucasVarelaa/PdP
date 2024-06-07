-- Funciones predefinidas

-- map :: (a -> b) -> [a] -> [b]
-- doble x = 2 x
-- map doble [1, 2] devuelve [2, 4]

-- filter :: (a -> Bool) -> [a] -> [a]
--
-- filter even [1, 2, 3, 4, 5] = [2, 4]

-- all :: (a -> Bool) -> [a] -> Bool
--
-- all even [2, 4, 6] --True todos son pares

-- any :: (a -> Bool) -> [a] -> Bool
--
-- any even [1, 3, 4] -- True, con que alguno sea par

--length :: String -> Int
-- Devuelve cantidad de caracteres de una palabra
totalCaracteres :: [String] -> Int
totalCaracteres lista = sum(map length lista) -- Sin el sum devuelve [4, 3, 3]
-- totalCaracteres ["Hola", "que", "tal"] -- 10

contarSi :: String -> Bool
contarSi palabra = length palabra > 3

cuantasPalabrasConMasDe3Caracteres :: [String] -> Int
cuantasPalabrasConMasDe3Caracteres lista = length (filter contarSi lista)
-- cuantasPalabrasConMasDe3Caracteres ["Hola", "Que", "Tal"] -- 1