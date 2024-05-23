-- COMPOSICION: (.)
-- (.) :: (b -> c) -> (a -> b) -> (a -> b) -- la composicion se lee de atras para adelante

doble :: Float -> Float
doble x = 2 * x

cuadrado :: Float -> Float
cuadrado x = x ** 2 

dobleCuadrado :: Float -> Float
dobleCuadrado = (doble.cuadrado)
-- map dobleCuadrado [1, 2, 3, 4] -- [2, 8, 18, 32]
-- filter (even.cuadrado) [1,2,3,4,5,6] -- [2,4,6] -- pregunta si son pares esos cuadrados

caracteresTotales :: [String] -> Int
longitudPalabras palabras = map length palabras
caracteresTotales palabra = (sum.longitudPalabras) palabra

