import comidas.*
import pepita.*
import extras.*

object _ {
    method dibujarEn(position) {

    }
}

object p {
    method dibujarEn(position) {
        pepita.position(position)
    }
}

object m {
    method dibujarEn(position) {
        game.addVisual(new Muro(position = position))
    }
}

object s {
    method dibujarEn(position) {
        game.addVisual(silvestre)
    }
}

object n {
    method dibujarEn(position) {
        nido.position(position)
        game.addVisual(nido)
    }
}
object mapa {

    const tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,n,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,m,_,p,_,_,_,_,_,_,_],     
     [_,_,_,m,_,_,_,_,_,_,_,_,_],     
     [_,_,_,m,m,m,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,s,_,_,_,_,_,_,_]         
    ].reverse()

    method dibujar() {
        game.height(tablero.size())
        game.width(tablero.get(0).size())

        (0..game.width() - 1).forEach({ x =>
            (0..game.height() -1).forEach({y =>
                tablero.get(y).get(x).dibujarEn(game.at(x,y))
            })
        })
        game.addVisual(pepita) //Lo pongo aca por el eje z


    }




}