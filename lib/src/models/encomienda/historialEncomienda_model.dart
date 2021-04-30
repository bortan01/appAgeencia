// To parse this JSON data, do
//
//     final historialEncomiendaModel = historialEncomiendaModelFromJson(jsonString);

import 'dart:convert';

HistorialEncomiendaModel historialEncomiendaModelFromJson(String str) =>
    HistorialEncomiendaModel.fromJson(json.decode(str));

String historialEncomiendaModelToJson(HistorialEncomiendaModel data) => json.encode(data.toJson());

class HistorialEncomiendaModel {
  HistorialEncomiendaModel({
    this.err,
    this.mensaje,
    this.encomiendas,
  });

  bool err;
  String mensaje;
  List<EncomiendaRealizada> encomiendas;

  factory HistorialEncomiendaModel.fromJson(Map<String, dynamic> json) => HistorialEncomiendaModel(
        err: json["err"],
        mensaje: json["mensaje"],
        encomiendas: List<EncomiendaRealizada>.from(json["Encomiendas"].map((x) => EncomiendaRealizada.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "Encomiendas": List<dynamic>.from(encomiendas.map((x) => x.toJson())),
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
    this.destino,
  });

  String idEncomienda;
  String idUsuario;
  String ciudadOrigen;
  String codigoPostalOrigen;
  DateTime fecha;
  String estado;
  String totalCliente;
  Destino destino;

  factory EncomiendaRealizada.fromJson(Map<String, dynamic> json) => EncomiendaRealizada(
        idEncomienda: json["id_encomienda"],
        idUsuario: json["id_usuario"],
        ciudadOrigen: json["ciudad_origen"],
        codigoPostalOrigen: json["codigo_postal_origen"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        totalCliente: json["total_cliente"],
        destino: json["destino"] == null ? new Destino() : Destino.fromJson(json["destino"]),
      );

  Map<String, dynamic> toJson() => {
        "id_encomienda": idEncomienda,
        "id_usuario": idUsuario,
        "ciudad_origen": ciudadOrigen,
        "codigo_postal_origen": codigoPostalOrigen,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "estado": estado,
        "total_cliente": totalCliente,
        "destino": destino == null ? null : destino.toJson(),
      };
}

class Destino {
  Destino({
    this.idDestino = '(0)',
    this.idEncomienda = '(0)',
    this.nombreClienteDestini = '(Sin Destino)',
    this.telefono = '(Sin Teléfono)',
    this.ciudadDestino = '(Sin Ciudad)',
    this.codigoPostalDestino = '(Sin Código)',
    this.direccionDestino = '(Sin Dirección)',
    this.alternaDestino = '(Sin Direccion Alternativa)',
  });

  String idDestino;
  String idEncomienda;
  String nombreClienteDestini;
  String telefono;
  String ciudadDestino;
  String codigoPostalDestino;
  String direccionDestino;
  String alternaDestino;

  factory Destino.fromJson(Map<String, dynamic> json) => Destino(
        idDestino: json["id_destino"],
        idEncomienda: json["id_encomienda"],
        nombreClienteDestini: json["nombre_cliente_destini"],
        telefono: json["telefono"],
        ciudadDestino: json["ciudad_destino"],
        codigoPostalDestino: json["codigo_postal_destino"],
        direccionDestino: json["direccion_destino"],
        alternaDestino: json["alterna_destino"],
      );

  Map<String, dynamic> toJson() => {
        "id_destino": idDestino,
        "id_encomienda": idEncomienda,
        "nombre_cliente_destini": nombreClienteDestini,
        "telefono": telefono,
        "ciudad_destino": ciudadDestino,
        "codigo_postal_destino": codigoPostalDestino,
        "direccion_destino": direccionDestino,
        "alterna_destino": alternaDestino,
      };
}
