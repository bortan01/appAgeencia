// To parse this JSON data, do
//
//     final tourPaqueteModel = tourPaqueteModelFromJson(jsonString);

import 'dart:convert';

TourPaqueteModel tourPaqueteModelFromJson(String str) =>
    TourPaqueteModel.fromJson(json.decode(str));

String tourPaqueteModelToJson(TourPaqueteModel data) =>
    json.encode(data.toJson());

class TourPaqueteModel {
  TourPaqueteModel({
    this.idTours,
    this.nombreTours,
    this.start,
    this.end,
    this.lugarSalida,
    this.precio,
    this.incluye,
    this.noIncluye,
    this.requisitos,
    this.promociones,
    this.descripcionTur,
    this.cuposDisponibles,
    this.nombreEncargado,
    this.estado,
    this.aprobado,
    this.tipo,
    this.descripcionForApp,
    this.foto,
    this.galeria,
  });

  int idTours;
  String nombreTours;
  DateTime start;
  DateTime end;
  List<String> lugarSalida;
  double precio;
  List<String> incluye;
  List<String> noIncluye;
  List<String> requisitos;
  List<dynamic> promociones;
  String descripcionTur;
  int cuposDisponibles;
  dynamic nombreEncargado;
  String estado;
  String aprobado;
  String tipo;
  String descripcionForApp;
  String foto;
  List<String> galeria;

  factory TourPaqueteModel.fromJson(Map<String, dynamic> json) =>
      TourPaqueteModel(
        idTours: int.parse(json["id_tours"]),
        nombreTours: json["nombreTours"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        lugarSalida: List<String>.from(json["lugar_salida"].map((x) => x)),
        precio: double.parse(json["precio"]),
        incluye: List<String>.from(json["incluye"].map((x) => x)),
        noIncluye: List<String>.from(json["no_incluye"].map((x) => x)),
        requisitos: List<String>.from(json["requisitos"].map((x) => x)),
        promociones: List<dynamic>.from(json["promociones"].map((x) => x)),
        descripcionTur: json["descripcion_tur"],
        cuposDisponibles: int.parse(json["cupos_disponibles"]),
        nombreEncargado: json["nombre_encargado"],
        estado: json["estado"],
        aprobado: json["aprobado"],
        tipo: json["tipo"],
        descripcionForApp: json["descripcionForApp"],
        foto: json["foto"],
        galeria: List<String>.from(json["galeria"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id_tours": idTours,
        "nombreTours": nombreTours,
        "start":
            "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "end":
            "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
        "lugar_salida": List<dynamic>.from(lugarSalida.map((x) => x)),
        "precio": precio,
        "incluye": List<dynamic>.from(incluye.map((x) => x)),
        "no_incluye": List<dynamic>.from(noIncluye.map((x) => x)),
        "requisitos": List<dynamic>.from(requisitos.map((x) => x)),
        "promociones": List<dynamic>.from(promociones.map((x) => x)),
        "descripcion_tur": descripcionTur,
        "cupos_disponibles": cuposDisponibles,
        "nombre_encargado": nombreEncargado,
        "estado": estado,
        "aprobado": aprobado,
        "tipo": tipo,
        "descripcionForApp": descripcionForApp,
        "foto": foto,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
      };
}
