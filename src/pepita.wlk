import wollok.game.*
import posiciones.*

object pepita {
	var energia = 100
	var property position = game.at(3, 8)
	const escenario = tablero
	var estadoPepita = vivo
	
	method comer(comida) {
		energia += comida.energiaQueOtorga()
	}
	
	method energia() = energia
	
	//method volar(kms) {
	//	energia -= 10 - kms
	//	}
	
	method volar(cantidad) {
		self.gastarEnergia(cantidad * 9)
	}
	method gastarEnergia(cantidad) {
		energia -= cantidad
		if (energia < 0) self.estadoPepita(muerto)
	}
	
	//method image() = "pepita.png"
	method image() {
	       return "pepita-" + estadoPepita + ".png"
	}
	method mover(direccion) {
		if (self.puedeMover(direccion)) {
			position = direccion.siguiente(self.position())
			self.volar(1)
		}
	}
	
	method puedeMover(direccion) = estadoPepita.puedeMover() && escenario.puedeIr(
		self.position(),
		direccion
	)
	
	method estadoPepita(_estadoPepita) {
		if (estadoPepita != _estadoPepita) {
			estadoPepita = _estadoPepita
			estadoPepita.activar()
		}
	}
	
	method atrapada() {
		self.estadoPepita(muerto)
	}
	
	method ganar() {
		self.estadoPepita(ganadora)
	}
	
	method caer() {
		if (self.puedeMover(abajo)) {
			position = abajo.siguiente(self.position())
		}
	}
	
	//method tieneEnergia() = energia > 100
	
	method esAtravesable() = true
	
	method text() = energia.toString()
	
	method textColor() = "FF00FF"
}

object vivo {
	method puedeMover() = true
	
	method activar() {
		
	}
}

object muerto {
	method puedeMover() = false
	
	method activar() {
		game.say(pepita, "Perdí!")
		game.schedule(3000, { game.stop() })
	}
}

object ganadora {
	method puedeMover() = false
	
	method activar() {
		game.say(pepita, "Gané!")
		game.schedule(3000, { game.clear() })
	}
}