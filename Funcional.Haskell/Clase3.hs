--data NombreDeTipo = Constructor TipoDeCampos CON PATTERN MATCHING
data Alumno = Alu{
    nombre :: String,
    legajo :: String,
    nota :: Int
} deriving (Show, Eq) -- DEFINE LAS FUNCIONES DE ACCESO DIRECTAMENTE

-- -- Accediendo a estructuras
-- nota :: Alumno -> Int
-- --nota (Alu elNombre elLegajo laNota) = laNota
-- nota (Alu _ _ laNota) = laNota

-- -- Definir todas las funciones de acceseso
-- nombre (Alu elNombre _ _) = elNombre
-- legajo (Alu _ elLegajo _) = elLegajo
-- --nota (Alu _ _ laNota) = laNota

-- Usar funciones a partir de lo de arriba
promociona :: Alumno -> Bool
promociona alumno = nota alumno >= 8

-- ghci> Alu "Jose" "123123-x" 8
-- Alu {nombre = "Jose", legajo = "123123-x", nota = 8}