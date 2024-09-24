import wollok.game.*

object manzana {
	const base= 5
	var madurez = 1
	
	method energiaQueOtorga() {
		return base * madurez	
	}
	
	method madurar() {
		madurez = madurez + 1
		//madurez += 1
	}

	method position() {
		return game.at(3,5)
	}

	method image() {
		return "manzana.png"
	}
	method solida() {
		return false
	}


}

object alpiste {

	method energiaQueOtorga() {
		return 20
	} 

	method position() {
		return game.at(6,6)
	}
	method image() {
		return "alpiste.png"
	}
	method solida() {
		return false
	}


}