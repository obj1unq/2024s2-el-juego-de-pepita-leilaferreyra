import wollok.game.*
import pepita.*
object nido {

	var property position = game.at(7, 8)

	method image() {
		return "nido.png"
	}
	
	method colision(personaje) {
		personaje.ganar()
	}
	method esAtravesable() {
		return true
	}
	

}

object silvestre {

	const presa = pepita

	method image() {
		return "silvestre.png"
	}

	method position() {
		return game.at(presa.position().x().max(2), 0)
	}
	
	method colision(personaje) {
		personaje.atrapada()
	}
	method esAtravesable() {
		return true
	}

}

object muro {
	
	var property position = game.at(5,5)
	
	method image() {
		return "muro.png"
	}
	method esAtravesable() {
		return false
	}
	  
}