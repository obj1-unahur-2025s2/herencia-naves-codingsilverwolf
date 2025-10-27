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

  /*
  Pongo un *método abstracto*. Decimos que ponemos la firma del método.
  Esto fuerza a que todos sus hijos sean polimórficos en este método. Además da error si la queremos instanciar. Por eso la llamamos *clase abstracta*
  Es cómo una especie de contrato. Se relaciona con el concepto de interfaz.
  */



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
  var misilesDesplegados = true
  const mensajes = []

  method estaInvisible() = estaInvisible

  method ponerseVisible(){
    estaInvisible = false
  }

  method ponerseInvisible(){
    estaInvisible = true
  }

  method desplegarMisiles(){
    misilesDesplegados = true
  }

  method replegarMisiles(){
    misilesDesplegados = false
  }

  method misilesDesplegados() = misilesDesplegados

  method emitirMensaje(mensaje){
    // ojota 1
    mensajes.add(mensaje)
  }

  method mensajesEmitidos() = mensajes

  method primerMensajeEmitido() = mensajes.first()
  method ultimoMensajeEmitido() = mensajes.last()
  method esEscueta() = mensajes.all{m => m.length() <= 30}
  method emitioMensaje(mensaje) = mensajes.contains(mensaje)


}

