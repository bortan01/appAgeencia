// To parse this JSON data, do
//
//     final cotizacionesPaquetesCliente = cotizacionesPaquetesClienteFromJson(jsonString);

import 'dart:convert';

CotizacionesPaquetesCliente cotizacionesPaquetesClienteFromJson(String str) => CotizacionesPaquetesCliente.fromJson(json.decode(str));

String cotizacionesPaquetesClienteToJson(CotizacionesPaquetesCliente data) => json.encode(data.toJson());

class CotizacionesPaquetesCliente {
    CotizacionesPaquetesCliente({
        this.err,
        this.cotizaciones,
    });

    bool err;
    List<Cotizacione> cotizaciones;

    factory CotizacionesPaquetesCliente.fromJson(Map<String, dynamic> json) => CotizacionesPaquetesCliente(
        err: json["err"],
        cotizaciones: List<Cotizacione>.from(json["cotizaciones"].map((x) => Cotizacione.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "cotizaciones": List<dynamic>.from(cotizaciones.map((x) => x.toJson())),
    };
}

class Cotizacione {
    Cotizacione({
        this.idCotizar,
        this.idCliente,
        this.peticion,
        this.respuesta,
        this.fechaPeticion,
        this.fechaRespuesta,
        this.precioRespuesta,
        this.visto,
    });

    String idCotizar;
    String idCliente;
    String peticion;
    String respuesta;
    DateTime fechaPeticion;
    DateTime fechaRespuesta;
    String precioRespuesta;
    String visto;

    factory Cotizacione.fromJson(Map<String, dynamic> json) => Cotizacione(
        idCotizar: json["idCotizar"],
        idCliente: json["id_cliente"],
        peticion: json["peticion"],
        respuesta: json["respuesta"],
        fechaPeticion: DateTime.parse(json["fechaPeticion"]),
        fechaRespuesta: DateTime.parse(json["fechaRespuesta"]),
        precioRespuesta: json["precioRespuesta"] == null ? null : json["precioRespuesta"],
        visto: json["visto"],
    );

    Map<String, dynamic> toJson() => {
        "idCotizar": idCotizar,
        "id_cliente": idCliente,
        "peticion": peticion,
        "respuesta": respuesta,
        "fechaPeticion": "${fechaPeticion.year.toString().padLeft(4, '0')}-${fechaPeticion.month.toString().padLeft(2, '0')}-${fechaPeticion.day.toString().padLeft(2, '0')}",
        "fechaRespuesta": "${fechaRespuesta.year.toString().padLeft(4, '0')}-${fechaRespuesta.month.toString().padLeft(2, '0')}-${fechaRespuesta.day.toString().padLeft(2, '0')}",
        "precioRespuesta": precioRespuesta == null ? null : precioRespuesta,
        "visto": visto,
    };
}
