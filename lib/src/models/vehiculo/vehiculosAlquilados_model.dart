// To parse this JSON data, do
//
//     final vehiculosAlquiladosModel = vehiculosAlquiladosModelFromJson(jsonString);

import 'dart:convert';

VehiculosAlquiladosModel vehiculosAlquiladosModelFromJson(String str) =>
    VehiculosAlquiladosModel.fromJson(json.decode(str));

String vehiculosAlquiladosModelToJson(VehiculosAlquiladosModel data) => json.encode(data.toJson());

class VehiculosAlquiladosModel {
  VehiculosAlquiladosModel({
    this.err,
    this.mensaje,
    this.historialDetalles,
  });

  bool err;
  String mensaje;
  List<HistorialDetalle> historialDetalles;

  factory VehiculosAlquiladosModel.fromJson(Map<String, dynamic> json) => VehiculosAlquiladosModel(
        err: json["err"],
        mensaje: json["mensaje"],
        historialDetalles:
            List<HistorialDetalle>.from(json["historialDetalles"].map((x) => HistorialDetalle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "historialDetalles": List<dynamic>.from(historialDetalles.map((x) => x.toJson())),
      };
}

class HistorialDetalle {
  HistorialDetalle({
    this.idvehiculo,
    this.idCliente,
    this.fechaReserva,
    this.resultadoTransaccion,
    this.monto,
    this.nombreDetalle,
    this.direccionRecogidaDetalle,
    this.direccionDevolucionDetalle,
    this.fechaDevolucion,
    this.horaDevolucion,
    this.totalDevolucion,
    this.puertas,
    this.pasajeros,
    this.precioDiario,
    this.descripcion,
    this.detalles,
    this.anio,
    this.modelo,
    this.transmision,
    this.nombreCategoria,
    this.opcAvanzadas,
    this.foto,
    this.galeria,
  });

  String idvehiculo;
  String idCliente;
  DateTime fechaReserva;
  String resultadoTransaccion;
  String monto;
  String nombreDetalle;
  String direccionRecogidaDetalle;
  String direccionDevolucionDetalle;
  DateTime fechaDevolucion;
  String horaDevolucion;
  String totalDevolucion;
  String puertas;
  String pasajeros;
  String precioDiario;
  String descripcion;
  String detalles;
  String anio;
  String modelo;
  String transmision;
  String nombreCategoria;
  List<String> opcAvanzadas;
  String foto;
  List<String> galeria;

  factory HistorialDetalle.fromJson(Map<String, dynamic> json) => HistorialDetalle(
        idvehiculo: json["idvehiculo"],
        idCliente: json["id_cliente"],
        fechaReserva: DateTime.parse(json["fecha_reserva"]),
        resultadoTransaccion: json["resultadoTransaccion"],
        monto: json["monto"],
        nombreDetalle: json["nombre_detalle"],
        direccionRecogidaDetalle: json["direccionRecogida_detalle"],
        direccionDevolucionDetalle: json["direccionDevolucion_detalle"],
        fechaDevolucion: json["fechaDevolucion"] == null ? null : DateTime.parse(json["fechaDevolucion"]),
        horaDevolucion: json["horaDevolucion"] == null ? null : json["horaDevolucion"],
        totalDevolucion: json["totalDevolucion"] == null ? null : json["totalDevolucion"],
        puertas: json["puertas"],
        pasajeros: json["pasajeros"],
        precioDiario: json["precio_diario"],
        descripcion: json["descripcion"],
        detalles: json["detalles"],
        anio: json["anio"],
        modelo: json["modelo"],
        transmision: json["transmision"],
        nombreCategoria: json["nombre_categoria"],
        opcAvanzadas: List<String>.from(json["opc_avanzadas"].map((x) => x)),
        foto: json["foto"],
        galeria: List<String>.from(json["galeria"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "idvehiculo": idvehiculo,
        "id_cliente": idCliente,
        "fecha_reserva": fechaReserva.toIso8601String(),
        "resultadoTransaccion": resultadoTransaccion,
        "monto": monto,
        "nombre_detalle": nombreDetalle,
        "direccionRecogida_detalle": direccionRecogidaDetalle,
        "direccionDevolucion_detalle": direccionDevolucionDetalle,
        "fechaDevolucion": fechaDevolucion == null
            ? null
            : "${fechaDevolucion.year.toString().padLeft(4, '0')}-${fechaDevolucion.month.toString().padLeft(2, '0')}-${fechaDevolucion.day.toString().padLeft(2, '0')}",
        "horaDevolucion": horaDevolucion == null ? null : horaDevolucion,
        "totalDevolucion": totalDevolucion == null ? null : totalDevolucion,
        "puertas": puertas,
        "pasajeros": pasajeros,
        "precio_diario": precioDiario,
        "descripcion": descripcion,
        "detalles": detalles,
        "anio": anio,
        "modelo": modelo,
        "transmision": transmision,
        "nombre_categoria": nombreCategoria,
        "opc_avanzadas": List<dynamic>.from(opcAvanzadas.map((x) => x)),
        "foto": foto,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
      };
}
