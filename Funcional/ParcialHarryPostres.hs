-- 1 A

data Postre = UnPostre {
    sabores :: [String],
    peso :: Float,
    temperatura :: Float
}deriving (Show,Eq)

prueba = UnPostre ["fruta","menta"] 100 25
prueba2 = UnPostre ["fruta","menta"] 100 25
otro = UnPostre ["chocolate"] 150 0
tarta = UnPostre ["manzana"] 250 15
bizcocho = UnPostre ["alcohol","fruta","crema"] 100 25

-- B

type Hechizo = Postre -> Postre

agregarSabor :: String -> Hechizo
agregarSabor sabor postre = postre{sabores = sabor : sabores postre}
--       agrega  Al final = postre{sabores = sabores postre ++ [sabor]}

modificarPeso :: (Float -> Float) -> Hechizo
modificarPeso modificador postre = postre{temperatura = modificador(temperatura postre)}

modificarTemperatura :: (Float -> Float) -> Hechizo
modificarTemperatura modificador postre = postre{peso = modificador(peso postre)}

incendio :: Hechizo
incendio  = modificarPeso(+1) . modificarTemperatura(*0.95)

immobulus :: Hechizo
immobulus  = modificarTemperatura(*0) 

wingardiumLeviosa :: Hechizo
wingardiumLeviosa  = agregarSabor "concentrado" . modificarPeso(*0.90)

diffindo :: Float -> Hechizo
diffindo num   = modificarPeso(*(1 - (num/100)))

riddikulus :: String -> Hechizo
riddikulus   = agregarSabor . reverse  -- ()sabor postre

avadaKedavra :: Hechizo
avadaKedavra postre = immobulus postre{sabores = []}

-- C

cantSabores :: Postre -> Int
cantSabores   = length . sabores  

estaListo :: Postre -> Bool
estaListo postre = peso postre > 0 && cantSabores postre > 0 && temperatura postre > 0

postresListos :: [Postre] -> [Postre]
postresListos = filter estaListo

postresListosPostHechizo :: Hechizo -> [Postre] -> [Postre]
postresListosPostHechizo hechizo = postresListos . map hechizo
--               Filtrar los postres resultantes . aplica el hechizo a cada postre en la lista.
-- [postre1, postre2, postre3], el resultado de map hechizo será [hechizo postre1, hechizo postre2, hechizo postre3].

-- D

sumaPesos :: [Postre] -> Float
sumaPesos   = foldr ((+) . peso) 0 --postres
sumaPesos2 ::  [Postre] -> Float
sumaPesos2  = sum . map peso
-- RECURSIVA
-- sumaPesos [] = 0
-- sumaPesos (postre:postres) = peso postre + sumaPesos postres

pesoPromedio :: [Postre] -> Float
pesoPromedio postres = sumaPesos postres / fromIntegral (length postres)

-- Pero como te dice tortas en mesa se supone que ya estan listas

pesoPromedioPostresListos :: [Postre] -> Float
pesoPromedioPostresListos = promedio . map peso . postresListos -- ()postres

promedio :: [Float] -> Float
promedio lista = sum lista / fromIntegral (length lista)

-- 2 Magos

data Mago = UnMago {
    hechizos :: [Hechizo],
    cantHorrorCruxes :: Int
}

-- A
sumarHorrorcruxesSiCumple :: Hechizo -> Postre -> Mago -> Mago
sumarHorrorcruxesSiCumple hechizo postre mago 
    | hechizo postre == avadaKedavra postre = mago{cantHorrorCruxes = cantHorrorCruxes mago + 1}
    | otherwise = mago

agregarHechizo :: Hechizo -> Mago -> Mago
agregarHechizo hechizo mago = mago{hechizos = hechizos mago ++ [hechizo]}

practicarHechizo :: Hechizo -> Postre -> Mago -> Mago
practicarHechizo hechizo postre  =  agregarHechizo hechizo . sumarHorrorcruxesSiCumple hechizo postre --()mago

-- B

masCantidaDeSabores :: Postre -> [Hechizo] -> Hechizo
masCantidaDeSabores _ [a] = a
masCantidaDeSabores postre (h1:h2:hs)
    | (cantSabores.h1) postre > (cantSabores.h2) postre = masCantidaDeSabores postre (h1:hs)
    | otherwise = masCantidaDeSabores postre (h2:hs)

mejorHechizo :: Postre -> Mago -> Hechizo
mejorHechizo postre   = masCantidaDeSabores postre . hechizos -- ()mago

-- 3

-- A) Construir una lista infinita de postres, y construir un mago con infinitos hechizos.
infinitosPostres :: [Postre]
infinitosPostres = tarta:infinitosPostres

merlin :: Mago
merlin = UnMago infinitosHechizos 5

infinitosHechizos :: [Hechizo]
infinitosHechizos = incendio:immobulus:infinitosHechizos

{-s
    B) Suponiendo que hay una mesa con infinitos postres, y pregunto si algún hechizo los deja listos ¿Existe alguna consulta que pueda
    hacer para que me sepa dar una respuesta? Justificar conceptualmente.

    RTA: Tomo como que la funcion recibiria una lista de hechizos y una lista de postres. En este caso, lazy evaluation nos ayudaria solo
    si es falso ya que para saber si todos quedan listos, deberia utilizar un any para la lista de hechizos y un all para la lista de postres
    entonces tendria que leer la lista entera de postres, si es verdadero que ese hechizo los deja listos (algo imposible si es infinita). 
    Por otro lado, si todos los hechizos devuelven por lo menos un postre que no este listo,  entonces devolveria False. Ya que todos los 
    all devolverian False. Y el any tambien daria False
-}

{-
    C) Suponiendo que un mago tiene infinitos hechizos ¿Existe algún caso en el que se puede encontrar al mejor hechizo? Justificar conceptualmente.

    RTA: En este caso, lazy evaluation no nos ayudaria ya que para saber el mejor hechizo debe leer la lista entera hasta que quede uno solo. Por lo que
    si es infinita, por mas que vayas sacando hechizos, nunca va a quedar uno solo. No hay ningun caso en el que se pueda encontrar el mejor hechizo.
-}

--Conclusion si le preguntas algo a una lista infinita que nunca llega a dar falso, no podremos saber si es verdad
-- ya que hay tortas infinitas

-- B) Mesa con Infinitos Postres:
-- En el caso de la mesa con infinitos postres, la evaluación perezosa no proporcionaría una solución para determinar si algún hechizo deja los postres listos. 
--Dado que la mesa tiene infinitos postres y potencialmente infinitos hechizos, intentar evaluar todas las combinaciones posibles de hechizos y postres sería 
--imposible de completar. Incluso si la evaluación perezosa pudiera ayudar a evitar el cálculo de todos los valores en algunas circunstancias, aún sería necesario 
--evaluar infinitos valores, lo que resultaría en un proceso que nunca terminaría.

-- C) Mago con Infinitos Hechizos:
-- En el caso del mago con infinitos hechizos, la evaluación perezosa tampoco proporcionaría una solución para encontrar el mejor hechizo. Si hay una lista
-- infinita de hechizos, y queremos encontrar el mejor hechizo, necesitaríamos evaluar toda la lista de hechizos para determinar cuál es el mejor. Dado que la 
--lista es infinita, nunca llegaríamos al final de la lista para hacer esta determinación. La evaluación perezosa no ayuda en este caso porque no puede evitar la
-- necesidad de evaluar todos los valores de la lista.
