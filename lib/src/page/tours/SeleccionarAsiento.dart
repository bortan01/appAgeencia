import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/turs/detalleTur_model.dart';
import 'package:peliculas/src/models/turs/transporte_model.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SeleccionarAsiento extends StatefulWidget {
  final DetalleTurModel detalle;
  final TransporteModel transporte;
  SeleccionarAsiento({
    Key key,
    @required this.detalle,
    this.transporte,
  }) : super(key: key);

  @override
  _SeleccionarAsientoState createState() => _SeleccionarAsientoState();
}

class _SeleccionarAsientoState extends State<SeleccionarAsiento> {
  final fcaffolKey = GlobalKey<ScaffoldState>();
  final turServices = new TurServices();
  double screenHeight;
  List<String> asientosSeleccionados = [];
  List<String> labelAsientos = [];
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: fcaffolKey,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            paginaFondo(),
            imagenPortada(context),
            cajaFormulario(context),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Carrito de Compras"),
    );
  }

  Widget paginaFondo() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "",
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget cajaFormulario(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  crearTitulo(
                      'Elija ${widget.detalle.cantidadAsientos.toString()} Asiento(s)'),
                  crearSubTitulo("(Asientos color verde)"),
                  SizedBox(height: 4.0),
                  _crearBus(
                      context: context,
                      asientosDerecho:
                          int.parse(widget.transporte.asientoDerecho),
                      asientosIzquierdos:
                          int.parse(widget.transporte.asientoIzquierdo),
                      filas: int.parse(widget.transporte.filas),
                      deshabilitados: widget.transporte.asientosDeshabilitados,
                      ocupados: widget.transporte.ocupados,
                      filaTrasera: widget.transporte.filaTrasera),
                  SizedBox(height: 20),
                  _botonPagar(context)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _botonPagar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        FlatButton(
          child: (_guardando) ? Text("Por favor espere...") : Text("Continuar"),
          color: Colors.blueAccent,
          textColor: Colors.white,
          padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: (_guardando) ? null : _reservar,
        )
      ],
    );
  }

  void _reservar() async {
    if (asientosSeleccionados.length != widget.detalle.cantidadAsientos) {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Oops",
        desc:
            "Debe de seleccionar ${widget.detalle.cantidadAsientos.toString()} asiento(s)",
        buttons: [
          DialogButton(
            child: Text(
              "Cerrar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color.fromRGBO(0, 179, 134, 1.0),
          )
        ],
      ).show();
    } else {
      setState(() {
        print("redibujando");
        _guardando = true;
      });

      final dynamic resultado =
          await turServices.guardarReserva(widget.detalle);
      Alert(
        context: context,
        type: AlertType.success,
        title: "Listo",
        desc: 'Será redirigido a nuestra pasarela de pago',
        buttons: [
          DialogButton(
            child: Text(
              "ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color.fromRGBO(0, 179, 134, 1.0),
          )
        ],
      ).show();
    }
  }

  void mostrarSnackbar(String mensaje) {
    final snack = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 2),
    );
    fcaffolKey.currentState.showSnackBar(snack);
  }

  Widget imagenPortada(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/img/portada.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Text crearTitulo(String tiulo) {
    return Text(
      tiulo,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }

  Text crearSubTitulo(String tiulo) {
    return Text(
      tiulo,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
    );
  }

  Widget _crearBus(
      {@required BuildContext context,
      @required int asientosIzquierdos,
      @required int asientosDerecho,
      @required int filas,
      @required String deshabilitados,
      @required List<String> ocupados,
      @required String filaTrasera}) {
    final int totalAsientos = asientosIzquierdos + asientosDerecho + 1;
    final scrimSize = MediaQuery.of(context).size;
    final dimensiones = ((scrimSize.width * 0.85) - 88) / totalAsientos;
    final List<String> asientosDeshabilitados = deshabilitados.split(",");
    final List<String> asientosNoDisponibles =
        new List.from(asientosDeshabilitados)..addAll(ocupados);

    List<Row> listaFilas = [];
    //con labelAsiento sele ira colocando el numero que apparece dentro de los cuadros
    int labelAsiento = 1;
    //se va a hacer una vuelta por cada fila
    for (var i = 1; i <= filas; i++) {
      List<Widget> elementos = [];
      //este es para dibujar los asientos izquierdos
      for (var j = 1; j <= asientosIzquierdos; j++) {
        elementos.add(Asiento(
          context: context,
          label: labelAsiento.toString(),
          identificador: '${i.toString()}_${j.toString()}',
          fondoActivo: Colors.green,
          fondoInactivo: Colors.red,
          dimensiones: dimensiones,
          asientosNoDisponibles: asientosNoDisponibles,
          agregar: agregarAsiento,
          eliminar: eliminarAsiento,
        ));
        labelAsiento++;
      }
      //Agregamos una separacion entre los asientos derechos y izquierdos
      elementos.add(Container(width: dimensiones, height: dimensiones));
      //este es para dibujar los asidento derechos
      for (var j = 2 + asientosIzquierdos;
          j <= asientosDerecho + asientosIzquierdos + 1;
          j++) {
        elementos.add(Asiento(
          context: context,
          label: labelAsiento.toString(),
          identificador: '${i.toString()}_${j.toString()}',
          fondoActivo: Colors.green,
          fondoInactivo: Colors.red,
          asientosNoDisponibles: asientosNoDisponibles,
          agregar: agregarAsiento,
          dimensiones: dimensiones,
          eliminar: eliminarAsiento,
        ));
        labelAsiento++;
      }
      //para agregar la fila trasera

      listaFilas.add(Row(
          mainAxisAlignment: MainAxisAlignment.center, children: elementos));
    }
    final espacio = Row(
      children: <Widget>[SizedBox(width: 20.0, height: 20.0)],
    );

    if (filaTrasera == "1") {
      final List<Widget> otraFila = [];
      for (var i = 1; i <= asientosDerecho + asientosIzquierdos + 1; i++) {
        otraFila.add(Asiento(
          context: context,
          label: labelAsiento.toString(),
          identificador: '${(filas + 2).toString()}_${i.toString()}',
          fondoActivo: Colors.green,
          fondoInactivo: Colors.red,
          asientosNoDisponibles: asientosNoDisponibles,
          agregar: agregarAsiento,
          dimensiones: dimensiones,
          eliminar: eliminarAsiento,
        ));
        labelAsiento++;
      }
      listaFilas.add(espacio);
      listaFilas.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center, children: otraFila));
    }

    return Column(
      children: listaFilas,
    );
  }

  void agregarAsiento(String identificadorAsiento, String label) {
    asientosSeleccionados.add(identificadorAsiento);
    labelAsientos.add(label);
  }

  void eliminarAsiento(String identificadorAsiento, String label) {
    asientosSeleccionados.remove(identificadorAsiento);
    labelAsientos.remove(label);
  }
}

class Asiento extends StatefulWidget {
  const Asiento(
      {Key key,
      @required this.context,
      @required this.label,
      @required this.fondoActivo,
      @required this.identificador,
      @required this.fondoInactivo,
      @required this.dimensiones,
      @required this.agregar,
      @required this.eliminar,
      @required this.asientosNoDisponibles})
      : super(key: key);

  final BuildContext context;
  final String label;
  final String identificador;
  final Color fondoActivo;
  final Color fondoInactivo;
  final double dimensiones;
  final Function agregar;
  final Function eliminar;
  final List<String> asientosNoDisponibles;

  @override
  _AsientoState createState() => _AsientoState();
}

class _AsientoState extends State<Asiento> {
  bool select = true;
  bool deshabilitado = false;

  @override
  Widget build(BuildContext context) {
    print("dibuejando asientos");
    //verificamos si el elemento identificador que recibimos existe en la lista
    //de los asientos que ya han sido ocupados o estan hinabilitados
    //y ocupamos el sentinela deshabilitado para manejarlo
    widget.asientosNoDisponibles.forEach((element) {
      if (widget.identificador == element) {
        deshabilitado = true;
        return;
      }
    });
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (!deshabilitado) {
              setState(() {
                if (select) {
                  widget.agregar(widget.identificador, widget.label);
                } else {
                  widget.eliminar(widget.identificador, widget.label);
                }
                select = !select;
              });
            }
            // return null;
          },
          child: Container(
            margin: EdgeInsets.all(2.0),
            height: widget.dimensiones,
            width: widget.dimensiones,
            child: Container(
                decoration: BoxDecoration(
                    //se verifica si el asiento esta deshabilitado
                    color: !deshabilitado
                        //sii esta habilitado se le coloca el color activo
                        ? select ? widget.fondoActivo : widget.fondoInactivo
                        //de lo contrario se le coloca un color negro
                        : Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                padding: EdgeInsets.only(top: widget.dimensiones / 3.5),
                child: Text(
                  widget.label,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      ],
    );
  }
}
