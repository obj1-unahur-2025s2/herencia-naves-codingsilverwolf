// clase abstracta. Es como una definición de lo que van a tener que hacer los hijos. No la voy a instanciar. Intancio sus hijos.

/*
nombre(parametros)
nombre()
Son dos métodos distintos. Tienen distinta firma.
*/

class Nave{
  var velocidad
  var direccion
  var combustible // sólo pondría el property si no hubiese ninguna lógica para cargarlo. Pero tengo cargar y descargar

  /*
  Pongo un *método abstracto*. Decimos que ponemos la firma del método. En este caso la firma es "method prepararViaje()"
  Esto fuerza a que todos sus hijos sean polimórficos en este método. Además da error si la queremos instanciar. Por eso la llamamos *clase abstracta*
  Es cómo una especie de contrato. Se relaciona con el concepto de interfaz.
  Ponemos los métodos abstractos arriba.
  */

  // El apartado Combustible hace que deje de ser abstracto la clase? No si hago accionAdicional(). Elegí mantener la abstracción.

  method estaTranquila()

  method prepararViaje()

  method escapar()

  method avisar()

  method tienePocaActividad() // es abstracta porque lo definen las hijas

  method estaDeRelajo() = self.estaTranquila() and self.tienePocaActividad()

  // Este no es abstracto. Ya está definido.
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  

  method condiconesParaLaTranquilidad() = combustible >= 4000 and velocidad <= 12000

  

  method accionAdicional(){
    self.cargarCombustible(3000)
    self.acelerar(5000)
  }


  method cargarCombustible(cantidad){
    combustible += cantidad
  }

  method descargarCombustible(cantidad){
    combustible -= cantidad
  }


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
  var property colorDeBaliza = "verde"
  var cambioDeColor = false

  method cambiarColorDeBaliza(colorNuevo){
    colorDeBaliza = colorNuevo
    cambioDeColor = true
  }

  override method prepararViaje(){
    self.accionAdicional()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol() 
  }

  // ojota con super(). Acá no corresponde, no tiene sentido.
  override method estaTranquila() = self.condiconesParaLaTranquilidad() and self.colorDeBaliza() != "rojo"

  override method tienePocaActividad() = not cambioDeColor

  override method escapar(){
    self.irHaciaElSol()
  }

  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }
}

class NaveDePasajeros inherits Nave{
  const pasajeros = 0
  var racionesDeComida = 2
  var racionesDeBebida = 2
  var racionesDeComidaServidas = 0

  method cargarComida(cuanto){
    racionesDeComida += cuanto
    racionesDeComidaServidas += cuanto
  }

  method cargarBebida(cuanto){
    racionesDeBebida += cuanto
  }

  override method prepararViaje(){
    self.accionAdicional()
    self.cargarComida(4*pasajeros)
    self.cargarBebida(6*pasajeros)
    self.acercarseUnPocoAlSol()
  }

  override method estaTranquila() = self.condiconesParaLaTranquilidad()

  override method tienePocaActividad() = racionesDeComidaServidas < 50

  override method escapar(){
    self.acelerar(velocidad)
  }

  override method avisar(){
    racionesDeComida = (racionesDeComida - pasajeros).min(0)
    racionesDeBebida = (racionesDeComida - 2*pasajeros).min(0)
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

  override method prepararViaje(){
    self.accionAdicional()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en  misión")
  }

  override method estaTranquila() = self.condiconesParaLaTranquilidad() and not self.misilesDesplegados()

  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar(){
    self.emitirMensaje("Amenaza recibida")
  }

  override method tienePocaActividad() = not self.estaInvisible() and not self.misilesDesplegados()

}

class NaveHospital inherits NaveDePasajeros{
  var quirofanosPreparados = false
  
  method prepararQuirofanos(){
    quirofanosPreparados = true
  }

  method quirofanosPreparados()= quirofanosPreparados

  method utilizarQuirofanos(){
    quirofanosPreparados = false
  }

  // uso la consulta de preparados. Además utilizo super() porque entonces hereda de pasajeros y pasajeros no es abstracta.
  override method estaTranquila() = super() and not self.quirofanosPreparados()
}

class NaveSigilosa inherits NaveDeCombate{

  override method estaTranquila() = super() and not self.estaInvisible()

}


