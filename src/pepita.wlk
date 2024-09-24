import wollok.game.*
import posiciones.*
import extras.*

object muerta {
	method puedeMover() {
		return false
	}

	method comprobarFinDeJuego(personaje) {
		game.say(personaje, "Perdí! :(")
		game.schedule(10, {game.stop()})
	}

	method fondo() {
		return 0
	}

}

object viva {
	method puedeMover() {
		return true
	}

	method comprobarFinDeJuego(personaje) {

	}

	method fondo() {
		return 1
	}

}

object victoriosa {
	method puedeMover() {
		return false
	}

	method comprobarFinDeJuego(personaje) {
		game.say(personaje, "Gané! :)")
		game.schedule(10, {game.stop()})
	}
	
	method fondo() {
		return 1
	}


}

object pepita {
	var energia = 1000
	var property position = game.at(3,9)
	const destino = nido
	const cazador = silvestre

	method comer(comida) {
		energia += comida.energiaQueOtorga()
	}

	method fondo() {
		return self.estado().fondo()
	}

	
	method comerAhi() {
		const comida = game.uniqueCollider(self)
		self.comerVisual(comida)
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

	method estado(){
		return if (self.estaEnDestino()){
			victoriosa
		} else if (self.muerta()){
			muerta
		} else {
			viva
		}
	}

	method muerta() {
		return self.estaAtrapada() or not self.puedeVolar(1)
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
		self.estado().comprobarFinDeJuego(self)
	}

	method mover(direccion) {
		self.validarMover(direccion)
		self.volar(1)
		self.desplazar(direccion)
	}

	method estaEnDestino(){
		return position == destino.position()
	}

	method estaAtrapada(){
		return position == cazador.position()
	}

	method solida() {
		return false
	}
}