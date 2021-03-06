import 'package:flutter/cupertino.dart';

class Precios {
  @required
  String titulo;
  @required
  int asiento;
  @required
  double pasaje;
  int cantidad;
  UniqueKey id = UniqueKey();

  Precios({this.titulo, this.asiento, this.pasaje, this.cantidad});

  @override
  String toString() {
    return this.titulo;
  }
}
