import wollok.game.*
import randomizer.*
object manzana {
	const base = 5
	var madurez = 1
	var property position = randomizer.emptyPosition()
	
	method energiaQueOtorga() = base * madurez
	
	method madurar() {
		madurez += 1
	}
	
	method image() = "manzana.png"
	
	method esAtravesable() = true
	
	method colision(personaje) {
		personaje.comer(self)
		game.removeVisual(self)
	}
	
	method text() = self.energiaQueOtorga().toString()
}

object alpiste {
	var property position = randomizer.emptyPosition()
	
	method energiaQueOtorga() = 20
	
	method image() = "alpiste.png"
	
	method esAtravesable() = true
	
	method colision(personaje) {
		personaje.comer(self)
		game.removeVisual(self)
	}
}