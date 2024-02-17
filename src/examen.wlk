object reguladorNutricional {
	
	method costoDeMantenimiento()  = 2000
}

object humificador {
  var humedad

  method costoDeMantenimiento() = if (self.humedad<= 0.3) 1000 else 4500
}

object panelesSolares {
	
	method costoDeMantenimiento() = 25000
}

class Terreno {
  var capacidadDePlantas
  
  method conjuntoDeCultivos() = []
  
  method precioDeCultivos() = self.conjuntoDeCultivos().map({cultivo => cultivo.precio()})
  
  method valorNutricionalCultivos() = self.conjuntoDeCultivos().map({cultivo => cultivo.valorNutricional()})
  
  method valorNutricionalTotal() = self.valorNutricionalCultivos().sum()
  
  method precioTotal() = self.precioDeCultivos().sum
  
  method valorNeto() = self.precioTotal() - self.costoDeMantenimiento()
  
  method mediaNutricional() = if (valorNutricionalCultivos().size()!= 0) {
  (valorNutricionalTotal() / conjuntoDeCultivos().size())
  } else 0
  
}

class CamposAbiertos inherits Terreno {
	const riqueza 
	
	method esRico() = riqueza > 100 
	
	method costoDeMantenimiento() = capacidadDePlantas * 4 * 500
	
} 

class Invernaderos inherits Terreno {
	const capacidadMaximaDePlantas
	
	 method esRico() = self.conjuntoDeCultivos().length < (capacidadMaximaDePlantas / 2) 
	 || dispositivoElectronico == reguladorNutricional
	 || (dispositivoElectronico == humificador && 20 < dispositivoElectronico.porcentajeDeHumedad() < 40)
	 
	 method costoDeMantenimiento() = 50000 + dispositivoElectronico.costoDeMantenimiento()
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
