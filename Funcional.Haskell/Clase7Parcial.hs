import Distribution.Simple.Setup (trueArg)
-- https://docs.google.com/document/d/e/2PACX-1vQX84Z8tKK_1tZtS27zFcqovm8zwTUSPDmPqJvyC5IoODbk9YQtLxxbfAftwLBwFH7a3J3WDz0BRg9k/pub

data Persona = Persona {
  nombrePersona :: String,
  suerte :: Int,
  inteligencia :: Int, -- 3 niveles (suerte, inteligencia, fuerza)
  fuerza :: Int
} deriving (Show, Eq)

data Pocion = Pocion {
  nombrePocion :: String,
  ingredientes :: [Ingrediente]
}

type Efecto = Persona -> Persona

data Ingrediente = Ingrediente {
  nombreIngrediente :: String,
  efectos :: [Efecto]
}

-- Ejemplo persona
hermione :: Persona
hermione = Persona
    { nombrePersona = "Hermione Granger",
      suerte = 20,
      inteligencia = 80,
      fuerza = 150
    }

harry :: Persona
harry = Persona 
    { 
    nombrePersona = "Harry Potter",
    suerte = 10,
    inteligencia = 50,
    fuerza = 200
    }

    -- Ejemplo de ingredientes
alasDeMurcielago :: Ingrediente
alasDeMurcielago = Ingrediente
    { nombreIngrediente = "Alas de murciélago",
      efectos = [\persona -> persona { suerte = suerte persona + 5 }] -- Incrementa la suerte en 5
    }

raizDeValeriana :: Ingrediente
raizDeValeriana = Ingrediente
    { nombreIngrediente = "raizDeValeriana",
      efectos = [\persona -> persona { inteligencia = inteligencia persona + 10 }] -- Incrementa la inteligencia en 10
    }
    
sangreDeUnicornio :: Ingrediente
sangreDeUnicornio = Ingrediente
    { nombreIngrediente = "sangreDeUnicornio",
      efectos = [\persona -> persona { suerte = suerte persona + 20 }] -- Incrementa la suerte en 20
    }

patasDeCabra :: Ingrediente
patasDeCabra = Ingrediente
    { nombreIngrediente = "patasDeCabra",
      efectos = [\persona -> persona { fuerza = fuerza persona + 15 }] -- Incrementa la fuerza en 15
    } 

-- Ejemplo de pociones
pocionSuerte :: Pocion
pocionSuerte = Pocion
    { nombrePocion = "Pocion de suerte",
      ingredientes = [alasDeMurcielago, raizDeValeriana, patasDeCabra, sangreDeUnicornio] -- Esta poción tiene alas de murciélago y raíz de valeriana
    }

pocionPoder :: Pocion
pocionPoder = Pocion
    { nombrePocion = "Pocion de poder",
      ingredientes = [sangreDeUnicornio] -- Esta poción contiene sangre de unicornio
    }

nombresDeIngredientesProhibidos = [
 "sangreDeUnicornio",
 "venenoDeBasilisco",
 "patasDeCabra",
 "efedrina"]

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun _ [ x ] = x
maximoSegun  f ( x : y : xs)
  | f x > f y = maximoSegun f (x:xs)
  | otherwise = maximoSegun f (y:xs)

niveles :: Persona -> [Int]
niveles persona = [suerte persona, inteligencia persona, fuerza persona]

-- 1

sumaDeNiveles :: Persona -> Int
sumaDeNiveles = sum . niveles --(. . .)persona

diferenciaDeNiveles :: Persona -> Int
diferenciaDeNiveles persona = (maximum . niveles) persona - (minimum . niveles) persona

-- diferenciaDeNiveles2 :: Persona -> Int
-- diferenciaDeNiveles2 persona = maximo - minimo 
--     where maximo = suerte persona `max` inteligencia persona `max` fuerza persona
--           minimo = suerte persona `min` inteligencia persona `min` fuerza persona

nivelesMayoresA :: Int -> Persona -> Int
nivelesMayoresA cant = length . filter(>cant) . niveles -- ()persona


--2

efectosDePocion :: Pocion -> [Efecto]
efectosDePocion = concat . map efectos . ingredientes --() pocion


-- 3

pocionHardcore :: [Pocion] -> [String]
pocionHardcore  = map nombrePocion . filter( (>3) . length . efectosDePocion)


pocionProhibida :: [Pocion] -> Int
pocionProhibida  = length . filter esProhibida

esProhibida :: Pocion -> Bool
esProhibida  = any((`elem` nombresDeIngredientesProhibidos) . nombreIngrediente) . ingredientes


todasDulces :: [Pocion] -> Bool
todasDulces  = all(("azucar" `elem`) . map nombreIngrediente . ingredientes)
--             all ( any (("azucar" == ) . nombreIngrediente) . ingredientes)


-- 4

tomarPocion :: Pocion -> Persona -> Persona
tomarPocion pocion personaInicial = 
    foldl(\persona efecto -> efecto persona) personaInicial (efectosDePocion pocion)


-- 5

esAntidotoDe :: Pocion -> Pocion -> Persona -> Bool
esAntidotoDe pocion1 pocion2 persona =
      ((==persona) . tomarPocion pocion2 . tomarPocion pocion1) persona


-- 6

personaMasAfectada :: Pocion -> (Persona -> Int) -> ([Persona] -> Persona)
personaMasAfectada pocion criterio = maximoSegun (criterio . tomarPocion pocion)

-- ghci> personaMasAfectada pocionSuerte sumaDeNiveles [harry, hermione]