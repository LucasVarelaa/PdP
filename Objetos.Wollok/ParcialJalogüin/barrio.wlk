class Barrio{
    var chicos = []

    method chicosConMasCaramelos() = chicos.sortBy{ 
        chico1, chico2 => chico1.caramelos() > chico2.caramelos() }.take(3)

    method elementosUsados() = chicos.filter(
		{ chico => chico.caramelos() > 10 }
	).flatmap({ chico => chico.elementos() }).asSet()
}