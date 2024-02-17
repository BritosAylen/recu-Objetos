object reguladorNutricional {
	method costoDeMantenimiento() 
}

object humificador {	
	method costoDeMantenimiento() 
}

object panelesSolares {
	method costoDeMantenimiento() 
}

class Terreno {
	var conjuntoDeCultivos = []
}

class CamposAbiertos inherits Terreno {
	const riqueza 
	method esRico() = riqueza > 100
	
} 

class Invernaderos inherits Terreno {
	const capacidadMaximaDePlantas
	
	 method esRico() = self.conjuntoDeCultivos.size < (capacidadMaximaDePlantas / 2)
}

object papa {
	method valorNutricional(esRico) = if(esRico) 1500 * 2 else 1500
	method precio(esRico) = ( self.valorNutricional(esRico) /2 )

}

object algodon {
	method  valorNutricional() = 0
	method  precio(esRico) = if (esRico) 500 else 0
}

object arbolFrutal {
	var property edad
	method valorNutricional() = 4000.min(edad * 3)
}
