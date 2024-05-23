sueldo :: String -> Int -> Int -> Float
sueldo cargo antiguedad horas = basico * adicional * proporcionalidad

    where
        basico :: Float
        basico
            | cargo == "titular" = 149000
            | cargo == "adjunto" = 116000
            | cargo == "ayudante" = 66000
            | otherwise = error "Cargo no valido"

        adicional :: Float
        adicional
            | antiguedad >= 24 = 2.20
            | antiguedad >= 10 = 1.50
            | antiguedad >= 5 = 1.30
            | antiguedad >= 3 = 1.20
            | otherwise = 1 -- No hay incremento por antiguedad

        proporcionalidad :: Float
        proporcionalidad
            | horas > 45 = 5
            | horas > 35 = 4
            | horas > 25 = 3
            | horas > 15 = 2
            | horas >= 5 = 1
            |otherwise = error "Cantidad de horas no valida"

------------------------------------------------------------------------------------------------------

diferenciaFamiliar sueldo canasta paritaria inflacion = 
    sueldo * porcentaje paritaria - canasta * porcentaje inflacion 

paraLlegarAFinDeMes cargo anios horas integrantes paritaria inflacion = 
    diferenciaFamiliar (sueldoDocente cargo anios horas) (canastaFamiliar integrantes) paritaria

canastaFamiliar 1 = 126000