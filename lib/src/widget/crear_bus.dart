import 'package:flutter/material.dart';
import 'package:peliculas/src/widget/asiento_widget.dart';

Widget crearBus({
  @required BuildContext context,
  @required int asientosDerecho,
  @required int asientosIzquierdos,
  @required int filas,
  @required String deshabilitados,
  @required Function agregarAsiento,
  @required Function eliminarAsiento,
  @required List<String> ocupados,
  @required String filaTrasera,
}) {
  final int totalAsientos = asientosDerecho + asientosIzquierdos + 1;
  final Size scrimSize = MediaQuery.of(context).size;
  final double dimensiones = ((scrimSize.width * 0.85) - 88) / totalAsientos;
  final List<String> asientosDeshabilitados = deshabilitados.split(",");
  final List<String> asientosNoDisponibles = new List.from(asientosDeshabilitados)..addAll(ocupados);

  List<Row> listaFilas = [];
  //con labelAsiento sele ira colocando el numero que apparece dentro de los cuadros
  int labelAsiento = 1;
  //se va a hacer una vuelta por cada fila
  for (var i = 1; i <= filas; i++) {
    List<Widget> elementos = [];
    //este es para dibujar los asientos izquierdos
    for (var j = 1; j <= asientosDerecho; j++) {
      elementos.add(AsientoWidget(
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
    for (var j = 2 + asientosDerecho; j <= asientosIzquierdos + asientosDerecho + 1; j++) {
      elementos.add(AsientoWidget(
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

    listaFilas.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: elementos));
  }
  final espacio = Row(
    children: <Widget>[SizedBox(width: 20.0, height: 20.0)],
  );

  if (filaTrasera == "1") {
    final List<Widget> otraFila = [];
    for (var i = 1; i <= asientosIzquierdos + asientosDerecho + 1; i++) {
      otraFila.add(AsientoWidget(
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
    listaFilas.add(new Row(mainAxisAlignment: MainAxisAlignment.center, children: otraFila));
  }

  return Column(
    children: listaFilas,
  );
}
