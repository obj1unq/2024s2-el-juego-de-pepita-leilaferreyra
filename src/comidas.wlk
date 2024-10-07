import wollok.game.*
import randomizer.*

object manzanaFactory {

	method construir(position) {
		return new Manzana(position=position)
	}
}
object alpisteFactory {
	method construir(position) {
		return new Alpiste(position = position,
		peso = 40.randomUpTo(100).truncate(2) )
	}
}
object administradorComidas {
	
	const creados = #{} 
	const factories = [ manzanaFactory, alpisteFactory]

	method nuevaComida() {
		if (self.hayEspacio()) {
			const comida = self.construirComida()
			game.addVisual(comida)
			creados.add(comida)
		}
	}

	method construirComida() {
		// const factory = if(0.randomUpTo(100) < 30) {
		// 	manzanaFactory
		// }
		// else {
		// 	alpisteFactory
		// }
		return factories.anyOne().construir(randomizer.emptyPosition()) 
	}

	method hayEspacio() {
		return creados.size() < 3
	}

	method remover(comida) {
		game.removeVisual(comida)
		creados.remove(comida)
	}
}
class Manzana {
	const base= 5
	var madurez = 1
	const position
	
	method energiaQueOtorga() {
		return base * madurez	
	}
	
	method madurar() {
		madurez = madurez + 1
		//madurez += 1
	}

	method position() {
		return position
	}

	method image() {
		return "manzana.png"
	}
	method solida() {
		return false
	}

	method colision(personaje) {
		personaje.comerVisual(self)
	}


}

class Alpiste {

	const position
	const peso

	method energiaQueOtorga() {
		return peso
	} 

	method text() {
		return peso.toString()
	}

	method position() {
		return position
	}
	method image() {
		return "alpiste.png"
	}
	method solida() {
		return false
	}

	method colision(personaje) {
		personaje.comerVisual(self)
	}



}