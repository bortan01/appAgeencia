// To parse this JSON data, do
//
//     final cotizacionClienteModel = cotizacionClienteModelFromJson(jsonString);

import 'dart:convert';

CotizacionClienteModel cotizacionClienteModelFromJson(String str) => CotizacionClienteModel.fromJson(json.decode(str));

String cotizacionClienteModelToJson(CotizacionClienteModel data) => json.encode(data.toJson());

class CotizacionClienteModel {
    CotizacionClienteModel({
        this.idUsuario,
        this.modelo,
        this.anio,
        this.caracteristicas,
        this.direccionRecogida,
        this.fechaRecogida,
        this.horaRecogida,
        this.direccionDevolucion,
        this.fechaDevolucion,
        this.horaDevolucion,
    });

    String idUsuario;
    String modelo;
    String anio;
    String caracteristicas;
    String direccionRecogida;
    String fechaRecogida;
    String horaRecogida;
    String direccionDevolucion;
    String fechaDevolucion;
    String horaDevolucion;

    factory CotizacionClienteModel.fromJson(Map<String, dynamic> json) => CotizacionClienteModel(
        idUsuario: json["id_usuario"],
        modelo: json["modelo"],
        anio: json["anio"],
        caracteristicas: json["caracteristicas"],
        direccionRecogida: json["direccion_recogida"],
        fechaRecogida: json["fechaRecogida"],
        horaRecogida: json["HoraRecogida"],
        direccionDevolucion: json["direccion_devolucion"],
        fechaDevolucion: json["fechaDevolucion"],
        horaDevolucion: json["HoraDevolucion"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "modelo": modelo,
        "anio": anio,
        "caracteristicas": caracteristicas,
        "direccion_recogida": direccionRecogida,
        "fechaRecogida": fechaRecogida,
        "HoraRecogida": horaRecogida,
        "direccion_devolucion": direccionDevolucion,
        "fechaDevolucion": fechaDevolucion,
        "HoraDevolucion": horaDevolucion,
    };
}
