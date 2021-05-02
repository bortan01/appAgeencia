import 'package:flutter/material.dart';

class AsientoWidget extends StatefulWidget {
  const AsientoWidget(
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
  _AsientoWidgetState createState() => _AsientoWidgetState();
}

class _AsientoWidgetState extends State<AsientoWidget> {
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}