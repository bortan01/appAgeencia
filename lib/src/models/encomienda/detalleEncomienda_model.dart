// To parse this JSON data, do
//
//     final detalleEncomienda = detalleEncomiendaFromJson(jsonString);

import 'dart:convert';

DetalleEncomienda detalleEncomiendaFromJson(String str) => DetalleEncomienda.fromJson(json.decode(str));

String detalleEncomiendaToJson(DetalleEncomienda data) => json.encode(data.toJson());

class DetalleEncomienda {
    DetalleEncomienda({
        this.err,
        this.mensaje,
        this.actualizaciones,
    });

    bool err;
    String mensaje;
    List<ActualizacionEncomienda> actualizaciones;

    factory DetalleEncomienda.fromJson(Map<String, dynamic> json) => DetalleEncomienda(
        err: json["err"],
        mensaje: json["mensaje"],
        actualizaciones: List<ActualizacionEncomienda>.from(json["detalles"].map((x) => ActualizacionEncomienda.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "detalles": List<dynamic>.from(actualizaciones.map((x) => x.toJson())),
    };
}

class ActualizacionEncomienda {
    ActualizacionEncomienda({
        this.idDetalleEnvio,
        this.idEncomienda,
        this.fecha,
        this.hora,
        this.descripcion,
    });

    String idDetalleEnvio;
    String idEncomienda;
    DateTime fecha;
    String hora;
    String descripcion;

    factory ActualizacionEncomienda.fromJson(Map<String, dynamic> json) => ActualizacionEncomienda(
        idDetalleEnvio: json["id_detalle_envio"],
        idEncomienda: json["id_encomienda"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id_detalle_envio": idDetalleEnvio,
        "id_encomienda": idEncomienda,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "descripcion": descripcion,
    };
}
