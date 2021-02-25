// To parse this JSON data, do
//
//     final transporte = transporteFromJson(jsonString);

import 'dart:convert';

TransporteModel transporteFromJson(String str) =>
    TransporteModel.fromJson(json.decode(str));

String transporteToJson(TransporteModel data) => json.encode(data.toJson());

class TransporteModel {
  TransporteModel({
    this.asientosDeshabilitados,
    this.nombreServicio,
    this.filaTrasera,
    this.asientoDerecho,
    this.asientoIzquierdo,
    this.filas,
    this.ocupados,
  });

  String asientosDeshabilitados;
  String nombreServicio;
  String filaTrasera;
  String asientoDerecho;
  String asientoIzquierdo;
  String filas;
  List<String> ocupados;

  factory TransporteModel.fromJson(Map<String, dynamic> json) =>
      TransporteModel(
        asientosDeshabilitados: json["asientos_deshabilitados"],
        nombreServicio: json["nombre_servicio"],
        filaTrasera: json["fila_trasera"],
        asientoDerecho: json["asiento_derecho"],
        asientoIzquierdo: json["asiento_izquierdo"],
        filas: json["filas"],
        ocupados: List<String>.from(json["ocupados"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "asientos_deshabilitados": asientosDeshabilitados,
        "nombre_servicio": nombreServicio,
        "fila_trasera": filaTrasera,
        "asiento_derecho": asientoDerecho,
        "asiento_izquierdo": asientoIzquierdo,
        "filas": filas,
        "ocupados": List<dynamic>.from(ocupados.map((x) => x)),
      };
}
