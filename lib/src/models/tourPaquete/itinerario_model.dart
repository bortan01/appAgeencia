// To parse this JSON data, do
//
//     final itinerarioModel = itinerarioModelFromJson(jsonString);

import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

ItinerarioModel itinerarioModelFromJson(String str) => ItinerarioModel.fromJson(json.decode(str));

String itinerarioModelToJson(ItinerarioModel data) => json.encode(data.toJson());

class ItinerarioModel {
  ItinerarioModel({
    this.err,
    this.evento,
  });

  bool err;
  List<Evento> evento;

  factory ItinerarioModel.fromJson(Map<String, dynamic> json) => ItinerarioModel(
        err: json["err"],
        evento: List<Evento>.from(json["evento"].map((x) => Evento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "evento": List<dynamic>.from(evento.map((x) => x.toJson())),
      };
}

class Evento {
  Evento({
    this.idItinerario,
    this.idTours,
    this.idSitioTuristico,
    this.costo,
    this.porUsuario,
    this.title,
    this.start,
    this.end,
    this.allDay,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  String idItinerario;
  String idTours;
  String idSitioTuristico;
  String costo;
  String porUsuario;
  String title;
  DateTime start;
  DateTime end;
  dynamic allDay;
  String backgroundColor;
  String borderColor;
  String textColor;

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        idItinerario: json["id_itinerario"],
        idTours: json["id_tours"],
        title: json["title"],
        start: (json["start"] == null) ? null : DateTime.parse(json["start"]),
        end: (json["end"] == null) ? null : DateTime.parse(json["end"]),
        backgroundColor: (json["backgroundColor"] == null) ? null : json["backgroundColor"],
      );

  Map<String, dynamic> toJson() => {
        "id_itinerario": idItinerario,
        "id_tours": idTours,
        "id_sitio_turistico": idSitioTuristico,
        "costo": costo,
        "por_usuario": porUsuario,
        "title": title,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "allDay": allDay,
        "backgroundColor": backgroundColor,
        "borderColor": borderColor,
        "textColor": textColor,
      };

  Color obtenerColor() {
    switch (backgroundColor) {
      case "rgb(0, 123, 255)":
        return Colors.blue;
        break;

      case "rgb(40, 167, 69)":
        return Colors.green;
        break;
      case "rgb(255, 193, 7)":
        return Colors.orange;
        break;

      case "rgb(220, 53, 69)":
        return Colors.red;
        break;

      case "#28a745":
        return Colors.green;
        break;
      default:
        return Colors.blue;
        break;
    }
  }

  String obtenerFecha() {
    if (start == null) {
      return '';
    }

    if (start == end) {
      return helper.transformarFecha(start);
    }
    if (start.day == end.day) {
      return '${helper.transformarFechaAndHora(start)} - ${helper.transformarHora(end)}';
    }
    return '${helper.transformarFechaAndHora(start)} - ${helper.transformarFechaAndHora(end)}';
  }
}
