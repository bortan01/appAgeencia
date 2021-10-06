// To parse this JSON data, do
//
//     final historiaAsesoriaModel = historiaAsesoriaModelFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

List<HistoriaAsesoriaModel> historiaAsesoriaModelFromJson(String str) =>
    List<HistoriaAsesoriaModel>.from(json.decode(str).map((x) => HistoriaAsesoriaModel.fromJson(x)));

String historiaAsesoriaModelToJson(List<HistoriaAsesoriaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoriaAsesoriaModel {
  HistoriaAsesoriaModel({
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
    this.nombre,
    this.correo,
    this.celular,
    this.nivel,
    this.uuid,
    this.fbToken,
    this.dui,
    this.activo,
    this.ultimaConexion,
    this.fechaConver,
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
  String nombre;
  String correo;
  String celular;
  String nivel;
  String uuid;
  dynamic fbToken;
  String dui;
  String activo;
  DateTime ultimaConexion;
  String fechaConver;

  factory HistoriaAsesoriaModel.fromJson(Map<String, dynamic> json) => HistoriaAsesoriaModel(
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
        nombre: json["nombre"],
        correo: json["correo"],
        celular: json["celular"],
        nivel: json["nivel"],
        uuid: json["uuid"],
        fbToken: json["fbToken"],
        dui: json["dui"],
        activo: json["activo"],
        ultimaConexion: DateTime.parse(json["ultimaConexion"]),
        fechaConver: json["fechaConver"],
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
        "nombre": nombre,
        "correo": correo,
        "celular": celular,
        "nivel": nivel,
        "uuid": uuid,
        "fbToken": fbToken,
        "dui": dui,
        "activo": activo,
        "ultimaConexion": ultimaConexion.toIso8601String(),
        "fechaConver": fechaConver,
      };

  Color obtenerColor() {
    switch (color) {
      case "#007bff":
        return Colors.blue;
        break;

      case "#007bff":
        return Colors.red;
        break;
      default:
        return Colors.blue;
        break;
    }
  }
}
