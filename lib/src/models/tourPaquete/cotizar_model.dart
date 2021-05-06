// To parse this JSON data, do
//
//     final cotizarModel = cotizarModelFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

CotizarModel cotizarModelFromJson(String str) => CotizarModel.fromJson(json.decode(str));

String cotizarModelToJson(CotizarModel data) => json.encode(data.toJson());

class CotizarModel {
  CotizarModel({
    this.idCotizar = '',
    this.idCliente = '',
    this.peticion = '',
    this.respuesta = 'SIN RESPUESTA',
    this.fechaPeticion = '',
    this.fechaRespuesta = '',
    this.precioRespuesta = 0.0,
    this.visto = '0',
  });

  String idCotizar;
  String idCliente;
  String peticion;
  String respuesta;
  String fechaPeticion;
  String fechaRespuesta;
  double precioRespuesta;
  String visto;

  factory CotizarModel.fromJson(Map<String, dynamic> json) => CotizarModel(
        idCotizar: json["idCotizar"],
        idCliente: json["id_cliente"],
        peticion: json["peticion"],
        respuesta: json["respuesta"],
        fechaPeticion: json["fechaPeticion"],
        fechaRespuesta: json["fechaRespuesta"],
        precioRespuesta: json["precioRespuesta"],
        visto: json["visto"],
      );

  Map<String, dynamic> toJson() {
    DateTime fecha = DateFormat('dd/MM/yyyy').parse(fechaPeticion);

    return {
      "idCotizar": idCotizar,
      "id_cliente": idCliente,
      "peticion": peticion,
      "respuesta": respuesta,
      "fechaPeticion": fecha.toIso8601String(),
      "fechaRespuesta": fechaRespuesta,
      "precioRespuesta": precioRespuesta.toString(),
      "visto": visto,
    };
  }
}
