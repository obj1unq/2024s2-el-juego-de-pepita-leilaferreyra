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

}

object alpiste {

	method energiaQueOtorga() {
		return 20
	} 

}