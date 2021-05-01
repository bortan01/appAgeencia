// To parse this JSON data, do
//
//     final responseReserva = responseReservaFromJson(jsonString);

import 'dart:convert';

ResponseReserva responseReservaFromJson(String str) => ResponseReserva.fromJson(json.decode(str));

String responseReservaToJson(ResponseReserva data) => json.encode(data.toJson());

class ResponseReserva {
  ResponseReserva({
    this.err,
    this.mensaje,
    this.reservas,
  });

  bool err;
  String mensaje;
  List<Reserva> reservas;

  factory ResponseReserva.fromJson(Map<String, dynamic> json) => ResponseReserva(
        err: json["err"],
        mensaje: json["mensaje"],
        reservas: List<Reserva>.from(json["reservas"].map((x) => Reserva.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "reservas": List<dynamic>.from(reservas.map((x) => x.toJson())),
      };
}

class Reserva {
  Reserva({
    this.idCliente,
    this.idTours,
    this.nombreTours,
    this.asientosSeleccionados,
    this.labelAsiento,
    this.cantidadAsientos,
    this.start,
    this.end,
    this.lugarSalida,
    this.incluye,
    this.noIncluye,
    this.requisitos,
    this.descripcionTur,
    this.fechaReserva,
    this.formaPagoUtilizada,
    this.monto,
    this.descripcionProducto,
    this.resultadoTransaccion,
    this.tipo,
    this.descripcionWeb,
    this.transporte,
    this.galeria,
  });

  String idCliente;
  String idTours;
  String nombreTours;
  String asientosSeleccionados;
  String labelAsiento;
  String cantidadAsientos;
  DateTime start;
  DateTime end;
  String lugarSalida;
  String incluye;
  String noIncluye;
  String requisitos;
  String descripcionTur;
  DateTime fechaReserva;
  String formaPagoUtilizada;
  String monto;
  String descripcionProducto;
  String resultadoTransaccion;
  String tipo;
  String descripcionWeb;
  Transporte transporte;
  List<String> galeria;

  factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        idCliente: json["id_cliente"],
        idTours: json["id_tours"],
        nombreTours: json["nombreTours"],
        asientosSeleccionados: json["asientos_seleccionados"],
        labelAsiento: json["label_asiento"],
        cantidadAsientos: json["cantidad_asientos"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        lugarSalida: json["lugar_salida"],
        incluye: json["incluye"],
        noIncluye: json["no_incluye"],
        requisitos: json["requisitos"],
        descripcionTur: json["descripcion_tur"],
        fechaReserva: DateTime.parse(json["fecha_reserva"]),
        formaPagoUtilizada: json["formaPagoUtilizada"],
        monto: json["monto"],
        descripcionProducto: json["descripcionProducto"],
        resultadoTransaccion: json["resultadoTransaccion"],
        tipo: json["tipo"],
        descripcionWeb: json["descripcionWeb"],
        transporte: json["transporte"] == null ? null : Transporte.fromJson(json["transporte"]),
        galeria: List<String>.from(json["galeria"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id_cliente": idCliente,
        "id_tours": idTours,
        "nombreTours": nombreTours,
        "asientos_seleccionados": asientosSeleccionados,
        "label_asiento": labelAsiento,
        "cantidad_asientos": cantidadAsientos,
        "start":
            "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "end":
            "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
        "lugar_salida": lugarSalida,
        "incluye": incluye,
        "no_incluye": noIncluye,
        "requisitos": requisitos,
        "descripcion_tur": descripcionTur,
        "fecha_reserva": fechaReserva.toIso8601String(),
        "formaPagoUtilizada": formaPagoUtilizada,
        "monto": monto,
        "descripcionProducto": descripcionProducto,
        "resultadoTransaccion": resultadoTransaccion,
        "tipo": tipo,
        "descripcionWeb": descripcionWeb,
        "transporte": transporte == null ? null : transporte.toJson(),
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
      };
}

class Transporte {
  Transporte({
    this.filas,
    this.asientoDerecho,
    this.asientoIzquierdo,
    this.filaTrasera,
    this.idTours,
    this.idTipoServicio,
  });

  String idTours;
  String idTipoServicio;
  int filas;
  int asientoDerecho;
  int asientoIzquierdo;
  int filaTrasera;

  factory Transporte.fromJson(Map<String, dynamic> json) => Transporte(
        idTipoServicio: json["id_tipo_servicio"],
        idTours: json["id_tours"],
        filas: int.parse(json["filas"]),
        asientoDerecho: int.parse(json["asiento_derecho"]),
        asientoIzquierdo: int.parse(json["asiento_izquierdo"]),
        filaTrasera: int.parse(json["fila_trasera"]),
      );

  Map<String, dynamic> toJson() => {
        "filas": filas,
        "asiento_derecho": asientoDerecho,
        "asiento_izquierdo": asientoIzquierdo,
        "fila_trasera": filaTrasera,
        "id_tours": idTours,
        "id_tipo_servicio": idTipoServicio,
      };
}
