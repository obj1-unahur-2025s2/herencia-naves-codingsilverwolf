// clase abstracta. Es como una definición de lo que van a tener que hacer los hijos. No la voy a instanciar. Intancio sus hijos.

/*
nombre(parametros)
nombre()
Son dos métodos distintos. Tienen distinta firma.
*/

class Nave{
  var velocidad
  var direccion

  // método de efecto. La cota se pone cuando lo setteamos, no cuando lo consultamos.
  method acelerar(cuanto){
    velocidad = (velocidad + cuanto).min(100000) 
  }
  method desacelerar(cuanto){
    velocidad = (velocidad - cuanto).max(0)

  }

  method irHaciaElSol(){
    direccion = 10
  }

  method escaparDelSol(){
    direccion = -10
  }

  method ponerseParaleloAlSol(){
    direccion = 0
  }

  method acercarseUnPocoAlSol(){
    direccion = (direccion+1).min(10)
  }

  method alejarseUnPocoAlSol(){
    direccion = (direccion-1).max(-10)
  }
}

class NaveBaliza inherits Nave{
  var colorDeBaliza = "verde"

  method cambiarColorDeBaliza(colorNuevo){
    colorDeBaliza = colorNuevo
  }
}

class NaveDePasajeros inherits Nave{
  const pasajeros
  var racionesDeComida
  var racionesDeBebida

  method cargarComida(cuanto){
    racionesDeComida += cuanto
  }

  method cargarBebida(cuanto){
    racionesDeBebida += cuanto
  }

}

class NaveDeCombate inherits Nave{
  var estaInvisible = true

  method estaInvisible() = estaInvisible
  method ponerseVisible(){
    estaInvisible = false
  }
  method ponerseInvisible(){
    estaInvisible = true
  }



}

