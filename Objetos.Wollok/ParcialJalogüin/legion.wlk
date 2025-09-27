class Legion{
    var chicos = []

    method capacidadSusto() = chicos.sum{ c => c.capacidadSusto() }

    method caramelos() = chicos.sum{ c => c.caramelos() }

    //method lider() = chicos.filter{chico ,n => n.capacidadSusto() > chico.capacidadSusto()}
    method lider() = chicos.max{ c => c.capacidadSusto() }

    method recibirCaramelos(cantidad){
        self.lider().recibirCaramelos(cantidad)
    }

    method agregarIntegrante(chico){
        chicos.add(chico)
    }
}