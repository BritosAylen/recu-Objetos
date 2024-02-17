class UserException inherits Exception{}

object reguladorNutricional {
	
	method costoDeMantenimiento()  = 2000
}

object humificador {
  var humedad

  method costoDeMantenimiento() = if (humedad <= 0.3) 1000 else 4500
}

object panelesSolares {
	
	method costoDeMantenimiento() = 25000
}

class Terreno {
  var capacidadDePlantas
  
  method plantasQuePuedenCrecer() = []
  
  method conjuntoDeCultivos() = []
  
  method precioDeCultivos() = self.conjuntoDeCultivos().map({cultivo => cultivo.precio()})
  
  method valorNutricionalCultivos() = self.conjuntoDeCultivos().map({cultivo => cultivo.valorNutricional()})
  
  method valorNutricionalTotal() = self.valorNutricionalCultivos().sum()
  
  method precioTotal() = self.precioDeCultivos().sum()
  
  method valorNeto() = self.precioTotal() - self.costoDeMantenimiento()
  
  method agregarPlanta(planta) {
  	if(self.conjuntoDeCultivos().size() < capacidadDePlantas && plantasQuePuedenCrecer.any({ tipoPlanta => tipoPlanta == planta })) {
    	self.conjuntoDeCultivos().add(planta)
  	} else {
    	throw new UserException(message = "No se pueden agregar más plantas")
  	}
   }
  
  method mediaNutricional() = if(self.valorNutricionalCultivos().size() != 0) {
  	(self.valorNutricionalTotal() / self.conjuntoDeCultivos().size())
	} else 0
	
	method agregarPlanta(planta) {
  	if(self.conjuntoDeCultivos().size() < capacidadDePlantas &&( plantasQuePuedenCrecer.any({ tipoPlanta => tipoPlanta == planta }))IIself.esRico()&&planta==palmera) {
    	self.conjuntoDeCultivos().add(planta)
  	} else {
    	throw new UserException(message = "No se pueden agregar más plantas")
  	}
   }
		
}

class CamposAbiertos inherits Terreno {
	const riqueza 
	
	override method plantasQuePuedenCrecer() = [papa, algodon, arbolFrutal]
	
	method esRico() = riqueza > 100 
	
	method costoDeMantenimiento() = capacidadDePlantas * 4 * 500
	
} 

class Invernaderos inherits Terreno {
	
	var dispositivoElectronico
	const capacidadMaximaDePlantas
	
	 method esRico() = self.conjuntoDeCultivos().size() < (capacidadMaximaDePlantas / 2) 
	 || dispositivoElectronico == reguladorNutricional
	 || (dispositivoElectronico == humificador && 20 < dispositivoElectronico.porcentajeDeHumedad() < 40)
	 
	 method costoDeMantenimiento() = 50000 + dispositivoElectronico.costoDeMantenimiento()
	 
	 override method plantasQuePuedenCrecer() = [papa, algodon]
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

object palmeraTropical {
  method precio(esRico) = if (esRico) * 5 else 0
  method valorNutricional() = (2 * edad).max(7500)
}
