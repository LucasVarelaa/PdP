data Personaje = UnPersonaje {
    nombre :: String,
    puntaje :: Int,
    inventario :: [Material]
} deriving Show

data Receta = UnaReceta {
    materiales :: [Material],
    tiempo :: Int,
    resultado :: Material
}
type Material = String

fogata,fosforo, madera,polloAsado,pollo,sueter,hielo,lobos,iglues :: Material
fogata = "fogata"
fosforo = "fosforo"
madera = "madera"
pollo = "pollo"
polloAsado = "pollo asado"
sueter = "sueter"
hielo = "hielo"
iglues = "iglues"
lobos = "lobos"

-- CRAFT
-- 1 Craftear un Objeto

tieneMaterialesRecetas :: Receta -> Personaje -> Bool
tieneMaterialesRecetas receta personaje = all(`elem` inventario personaje) (materiales receta)

eliminarPrimero :: Material -> [Material] -> [Material]
eliminarPrimero _ [] = []
eliminarPrimero material (xi:xs)
    | material == xi = xs
    | otherwise = xi : eliminarPrimero material xs
-- si no coincide, dejar el primero y seguir con el resto de la lista 

eliminarMateriales :: [Material] -> [Material] -> [Material]
eliminarMateriales inventario [] =  []
eliminarMateriales inventario (xi:xs) = eliminarMateriales (eliminarPrimero xi inventario) xs

craftearObjeto :: Receta -> Personaje -> Personaje
craftearObjeto receta personaje
    | tieneMaterialesRecetas receta personaje = personaje {inventario = eliminarMateriales (inventario personaje) (materiales receta) ++ [resultado receta],
      puntaje = puntaje personaje + 10 * tiempo receta}
    | otherwise = personaje{puntaje = puntaje personaje - 100}

-- 2

objetoQueDuplicanPuntaje :: Personaje -> [Receta] -> [Receta]
objetoQueDuplicanPuntaje personaje receta = filter duplicariaPuntaje receta
    where duplicariaPuntaje receta = 2 * puntaje personaje <= puntaje (craftearObjeto receta personaje)

-- craftearTodos :: Personaje -> [Receta] -> Personaje
-- craftearTodos  = foldr craftearObjeto 

-- craftearTodos :: [Receta] -> Personaje -> Personaje
-- craftearTodos recetas personaje
--   = foldl (flip craftearObjeto) personaje recetas

craftearTodos :: [Receta] -> Personaje -> Personaje
craftearTodos [] personaje = personaje
craftearTodos (receta:recetas) personaje = craftearTodos recetas (craftearObjeto receta personaje)

mejorCrafteo :: [Receta] -> Personaje -> Bool
mejorCrafteo receta personaje = puntaje (craftearTodos receta personaje) > puntaje(craftearTodos(reverse receta) personaje)

-- MINE

data Bioma = UnBioma{
    materialesPresentes :: [Material],
    materialNecesario :: Material
}

biomaArtico :: Bioma
biomaArtico = UnBioma [hielo, iglues, lobos] sueter

type Herramienta = [Material] -> Material

hacha :: Herramienta
hacha = last

espada :: Herramienta
espada = head 

pico :: Int -> Herramienta
pico = flip (!!) 

-- Nueva herramienta que obtiene un material del medio
herramientaDelMedio :: Herramienta
herramientaDelMedio materiales = materiales !! (length materiales `div` 2)

-- Nueva herramienta utilizando una expresión lambda
herramientaInversa :: Herramienta
herramientaInversa materiales = head (reverse materiales)
--                              last materiales

minarConHerramienta :: Herramienta -> Personaje -> [Material] -> Personaje
minarConHerramienta herramienta personaje materiales = personaje {
    inventario = inventario personaje ++ [herramienta materiales], 
    puntaje = puntaje personaje + 50
}

minar :: Herramienta -> Personaje -> Bioma -> Personaje
minar herramienta personaje bioma
    | materialNecesario bioma `elem` inventario personaje = minarConHerramienta herramienta personaje (materialesPresentes bioma)
   -- compara un elemento y busca en toda la lista si lo encuentra--elem ---a -> [a] -> Bool. | es como un if
    | otherwise = personaje

    {-
EJEMPLOS DE USO DE HERRAMIENTAS:

ghci> minar hacha biomaArtico juan
UnJugador {nombre = "juan", puntaje = 70, inventario = ["lobos","madera","fosforo","pollo","sueter"]}

ghci> minar (pico 1) biomaArtico juan
UnJugador {nombre = "juan", puntaje = 70, inventario = ["iglues","madera","fosforo","pollo","sueter"]}

-}

-- PARTE 3

listaPollosInfinitos :: [String]
listaPollosInfinitos = pollo : listaPollosInfinitos

{-
> minar espada (UnBioma listaPollosInfinitos sueter) juan
UnJugador {nombre = "juan", puntaje = 1050, inventario = ["pollo","madera","fosforo","pollo crudo","sueter"]}

-}