// To parse this JSON data, do
//
//     final asesoriaSaveModel = asesoriaSaveModelFromJson(jsonString);

import 'dart:convert';

AsesoriaSaveModel asesoriaSaveModelFromJson(String str) => AsesoriaSaveModel.fromJson(json.decode(str));

String asesoriaSaveModelToJson(AsesoriaSaveModel data) => json.encode(data.toJson());

class AsesoriaSaveModel {
  AsesoriaSaveModel({
    this.fecha,
    this.usuario,
    this.idCliente,
    this.start,
    this.title,
    this.cobros,
  });

  String fecha;
  String usuario;
  String idCliente;
  String start;
  String title;
  String cobros;

  factory AsesoriaSaveModel.fromJson(Map<String, dynamic> json) => AsesoriaSaveModel(
        fecha: json["fecha"],
        usuario: json["usuario"],
        idCliente: json["id_cliente"],
        start: json["start"],
        title: json["title"],
        cobros: json["cobros"],
      );

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "usuario": usuario,
        "id_cliente": idCliente,
        "start": start,
        "title": title,
        "cobros": cobros,
      };
}
