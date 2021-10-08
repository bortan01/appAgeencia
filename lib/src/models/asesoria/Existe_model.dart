// To parse this JSON data, do
//
//     final existeModelDart = existeModelDartFromJson(jsonString);

import 'dart:convert';

ExisteModelDart existeModelDartFromJson(String str) => ExisteModelDart.fromJson(json.decode(str));

String existeModelDartToJson(ExisteModelDart data) => json.encode(data.toJson());

class ExisteModelDart {
  ExisteModelDart({
    this.err,
    this.mensaje,
    this.existe,
  });

  bool err;
  String mensaje;
  Existe existe;

  factory ExisteModelDart.fromJson(Map<String, dynamic> json) => ExisteModelDart(
        err: json["err"],
        mensaje: json["mensaje"],
        existe: json["existe"] == null ? null : Existe.fromJson(json["existe"]),
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "existe": existe.toJson(),
      };
}

class Existe {
  Existe({
    this.idCita,
    this.idCliente,
    this.title,
    this.color,
    this.textColor,
    this.start,
    this.fecha,
    this.hora,
    this.estadoCita,
    this.asistencia,
    this.cobros,
  });

  String idCita;
  String idCliente;
  String title;
  String color;
  String textColor;
  DateTime start;
  DateTime fecha;
  String hora;
  String estadoCita;
  String asistencia;
  String cobros;

  factory Existe.fromJson(Map<String, dynamic> json) => Existe(
        idCita: json["id_cita"],
        idCliente: json["id_cliente"],
        title: json["title"],
        color: json["color"],
        textColor: json["textColor"],
        start: DateTime.parse(json["start"]),
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        estadoCita: json["estado_cita"],
        asistencia: json["asistencia"],
        cobros: json["cobros"],
      );

  Map<String, dynamic> toJson() => {
        "id_cita": idCita,
        "id_cliente": idCliente,
        "title": title,
        "color": color,
        "textColor": textColor,
        "start": start.toIso8601String(),
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "estado_cita": estadoCita,
        "asistencia": asistencia,
        "cobros": cobros,
      };
}
