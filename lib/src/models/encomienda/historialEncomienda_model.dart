// To parse this JSON data, do
//
//     final historialEncomienda = historialEncomiendaFromJson(jsonString);

import 'dart:convert';

HistorialEncomiendaModel historialEncomiendaFromJson(String str) => HistorialEncomiendaModel.fromJson(json.decode(str));

String historialEncomiendaToJson(HistorialEncomiendaModel data) => json.encode(data.toJson());

class HistorialEncomiendaModel {
    HistorialEncomiendaModel({
        this.err,
        this.mensaje,
        this.encomiendasRealizadas,
    });

    bool err;
    String mensaje;
    List<EncomiendaRealizada> encomiendasRealizadas;

    factory HistorialEncomiendaModel.fromJson(Map<String, dynamic> json) => HistorialEncomiendaModel(
        err: json["err"],
        mensaje: json["mensaje"],
        encomiendasRealizadas: List<EncomiendaRealizada>.from(json["Encomiendas"].map((x) => EncomiendaRealizada.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "Encomiendas": List<dynamic>.from(encomiendasRealizadas.map((x) => x.toJson())),
    };
}

class EncomiendaRealizada {
    EncomiendaRealizada({
        this.idEncomienda,
        this.idUsuario,
        this.ciudadOrigen,
        this.codigoPostalOrigen,
        this.fecha,
        this.estado,
        this.totalCliente,
    });

    String idEncomienda;
    String idUsuario;
    String ciudadOrigen;
    String codigoPostalOrigen;
    DateTime fecha;
    String estado;
    String totalCliente;

    factory EncomiendaRealizada.fromJson(Map<String, dynamic> json) => EncomiendaRealizada(
        idEncomienda: json["id_encomienda"],
        idUsuario: json["id_usuario"],
        ciudadOrigen: json["ciudad_origen"],
        codigoPostalOrigen: json["codigo_postal_origen"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        totalCliente: json["total_cliente"],
    );

    Map<String, dynamic> toJson() => {
        "id_encomienda": idEncomienda,
        "id_usuario": idUsuario,
        "ciudad_origen": ciudadOrigen,
        "codigo_postal_origen": codigoPostalOrigen,
        "fecha": fecha,
        "estado": estado,
        "total_cliente": totalCliente,
    };
}
