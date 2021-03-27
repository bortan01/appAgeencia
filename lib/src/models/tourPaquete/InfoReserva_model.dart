// To parse this JSON data, do
//
//     final infoReservaModel = infoReservaModelFromJson(jsonString);

import 'dart:convert';

import 'package:peliculas/src/models/tourPaquete/transporte_model.dart';

InfoReservaModel infoReservaModelFromJson(String str) =>
    InfoReservaModel.fromJson(json.decode(str));

String infoReservaModelToJson(InfoReservaModel data) =>
    json.encode(data.toJson());

class InfoReservaModel {
  InfoReservaModel({
    this.nombre,
    this.start,
    this.end,
    this.precio,
    this.cupos,
    this.descripcionTur,
    this.incluye,
    this.noIncluye,
    this.requisitos,
    this.lugarSalidas,
    this.promociones,
    this.transporte,
  });

  String nombre;
  DateTime start;
  DateTime end;
  double precio;
  int cupos;
  String descripcionTur;
  List<String> incluye;
  List<String> noIncluye;
  List<String> requisitos;
  List<String> lugarSalidas;
  List<dynamic> promociones;
  TransporteModel transporte;

  factory InfoReservaModel.fromJson(Map<String, dynamic> json) {
    TransporteModel transporte;
    if (json["transporte"] == null) {
      transporte = new TransporteModel(
          asientoDerecho: '',
          asientoIzquierdo: '',
          asientosDeshabilitados: '',
          filaTrasera: '',
          filas: '',
          nombreServicio: '',
          ocupados: []);
    } else {
      transporte = TransporteModel.fromJson(json["transporte"]);
    }

    return InfoReservaModel(
      nombre: json["nombre"],
      start: DateTime.parse(json["start"]),
      end: DateTime.parse(json["end"]),
      precio:  double.parse(json["precio"]),
      cupos: int.parse(json["cupos"]),
      descripcionTur: json["descripcion_tur"],
      incluye: List<String>.from(json["incluye"].map((x) => x)),
      noIncluye: List<String>.from(json["no_incluye"].map((x) => x)),
      requisitos: List<String>.from(json["requisitos"].map((x) => x)),
      lugarSalidas: List<String>.from(json["lugar_salidas"].map((x) => x)),
      promociones: List<dynamic>.from(json["promociones"].map((x) => x)),
      transporte:  transporte
    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "start":
            "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "end":
            "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
        "precio": precio,
        "cupos": cupos,
        "descripcion_tur": descripcionTur,
        "incluye": List<dynamic>.from(incluye.map((x) => x)),
        "no_incluye": List<dynamic>.from(noIncluye.map((x) => x)),
        "requisitos": List<dynamic>.from(requisitos.map((x) => x)),
        "lugar_salidas": List<dynamic>.from(lugarSalidas.map((x) => x)),
        "promociones": List<dynamic>.from(promociones.map((x) => x)),
        "transporte": transporte,
      };
}
