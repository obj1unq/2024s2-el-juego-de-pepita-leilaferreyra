import wollok.game.*
import posiciones.*
import extras.*

object muerta {
	method puedeMover() {
		return false
	}

	method fondo() {
		return 0
	}

}

object viva {
	method puedeMover() {
		return true
	}


	method fondo() {
		return 1
	}

}

object victoriosa {
	method puedeMover() {
		return false
	}
	
	method fondo() {
		return 1
	}


}

object pepita {

	var energia = 100
	var property position = game.at(3,9)
	var property estado = viva

	method comer(comida) {
		energia += comida.energiaQueOtorga()
	}

	method ganar() {
		estado = victoriosa
		game.say(self, "Gané! :(")
		game.schedule(3000, {game.stop()})
	}

	method perder() {
		estado = muerta
		game.say(self, "Perdí! :)")
		game.schedule(3000, {game.stop()})
	}
	
	method fondo() {
		return self.estado().fondo()
	}

	method comerVisual(comida) {
		self.comer(comida)
		game.removeVisual(comida)
	}

	method energiaParaVolar(kms) {
		return 10 + kms
	}

	method puedeVolar(kms) {
		return energia >= self.energiaParaVolar(kms)
	}

	method validarVolar(kms) {
		if (not self.puedeVolar(kms)) {
			self.error("no tengo energia para volar " + kms + " kms")
		}
	} 
	method volar(kms) {
		self.validarVolar(kms)
		energia = energia - self.energiaParaVolar(kms)
	}
	
	method energia() = energia
	
	method image(){
		return "pepita-" + self.estado() + ".png"
	}

	method caer() {
		self.desplazar(abajo)
	}

	
	method text() {
		return self.energia().toString()
	}

	method textColor() {
		return "FF0000FF"
	}
	
	method validarCapacidadMovimiento() {
		if (not self.estado().puedeMover()) {
			self.error("No puedo moverme porque estoy " + self.estado())
		}
	}

	method haySolido(_position) {
		return game.getObjectsIn(_position).any({cosa => cosa.solida()})
	}

	method validarAtravesables(_position) {
		if (self.haySolido(_position)) {
			self.error("No puedo ir ahí")
		}
	}

	method validarMover(direccion) {
		self.validarCapacidadMovimiento()
		const siguiente = direccion.siguiente(self.position())
		tablero.validarDentro(siguiente)
		self.validarAtravesables(siguiente)
	}

	method desplazar(direccion) {
		self.validarMover(direccion)
		position = direccion.siguiente(self.position())
		if (position.y() == 0 and not self.puedeVolar(1)) {
			self.perder()
		}
	}

	method mover(direccion) {
		self.validarMover(direccion)
		self.volar(1)
		self.desplazar(direccion)
	}

	method solida() {
		return false
	}
}