import wollok.game.*
import pepita.*
object nido {
    const property position = game.at(7,8)

    method image(){
        return "nido.png"
    }

    method solida() {
		return false
	}

    method colisiono(personaje) {
        personaje.ganar()
    }

}

object silvestre{
    const presa = pepita 

    method image(){
        return "silvestre.png"
    }
    method position(){
        return game.at(presa.position().x().max(3),0)
    }

    method solida() {
		return false
	}

    method colisiono(personaje) {
        personaje.perder()        
    }

}

//Este es un fondo que se calcula segun el estado de pepita
// object fondo {

//     method position() = game.at(0,0)


//     method image() {
//         return "fondo" + pepita.fondo() + ".jpg"
//     }
// }


//Este es un fondo que se cambia ante un evento (alguien tiene que llamar directamente al cambiar)
//y se recuerda cual fue su ultimo estado
object fondo {

    method position() = game.at(0,0)

    var escenario = 0

    method image() {
        return "fondo" + escenario + ".jpg"
    }

    method cambiar() {
         escenario = (escenario + 1) % 2
    }
    method solida() {
		return false
	}

}

object reloj {

    var segundos = 0

    method position() {
        return game.at(0, game.height() - 1 )
    }

    method text() {
        return segundos.toString()
    }

    method textColor() {
        return "FFFF00FF"
    }

    method tick() {
        segundos = (segundos + 1) % 1000
    }
    method solida() {
		return false
	}

}

object muro {

    method image() {
        return "muro.png"
    }

    method position() {
        return game.at(3,3)
    }
    method solida() {
		return true
	}

}
