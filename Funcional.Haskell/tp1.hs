data Ciudad = UnaCiudad
  { nombre :: String,
    fundacion :: Int,
    atracciones :: [String],
    costoVida :: Float
  }
  deriving (Show)

miCiudad :: Ciudad
miCiudad =
  UnaCiudad
    { nombre = "Azul",
      fundacion = 1832,
      atracciones = ["Teatro Espanol", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"],
      costoVida = 190
    }

valorCiudad :: Ciudad -> Float
valorCiudad ciudad
  | fundacion ciudad < 1800 = 5 * (1800 - fromIntegral (fundacion ciudad))
  | null (atracciones ciudad) = 2 * costoVida ciudad
  | otherwise = 3 * costoVida ciudad

vocal :: Char -> Bool
vocal v = v `elem` "aeiouAEIOU"

atraccionCopada :: Ciudad -> Bool
atraccionCopada ciudad = any (vocal . head) (atracciones ciudad)

esSobria :: Ciudad -> Int -> Bool
esSobria ciudad cantLetras = all ((>= cantLetras) . length) (atracciones ciudad) && not (null (atracciones ciudad))

tieneNombreRaro :: Ciudad -> Bool
tieneNombreRaro ciudad = length (nombre ciudad) < 5

sumarAtraccion :: Ciudad -> String -> Ciudad
sumarAtraccion ciudad atraccionNueva =
  ciudad
    { atracciones = atracciones ciudad ++ [atraccionNueva],
      costoVida = costoVida ciudad * 1.2
    }

atravesarCrisis :: Ciudad -> Ciudad
atravesarCrisis ciudad = 
  ciudad
    { atracciones = init (atracciones ciudad),
      costoVida = costoVida ciudad * 0.9
    }

remodelacion :: Ciudad -> Float -> Ciudad
remodelacion ciudad porcentaje =
  ciudad
    { nombre = "New " ++ nombre ciudad,
      costoVida = costoVida ciudad * (1 + porcentaje / 100)
    }

reevaluacion :: Ciudad -> Int -> Ciudad
reevaluacion ciudad cantLetras
  | esSobria ciudad cantLetras =
      ciudad
        { costoVida = costoVida ciudad * 1.1
        }
  | otherwise =
      ciudad
        { costoVida = costoVida ciudad - 3
        }

transformacion ::Ciudad -> Float -> Int -> Ciudad
transformacion = (reevaluacion .) . ((atravesarCrisis .) . remodelacion)
