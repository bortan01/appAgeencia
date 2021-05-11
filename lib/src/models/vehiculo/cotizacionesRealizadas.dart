// To parse this JSON data, do
//
//     final cotizacionesRealizadas = cotizacionesRealizadasFromJson(jsonString);

import 'dart:convert';

CotizacionesRealizadas cotizacionesRealizadasFromJson(String str) => CotizacionesRealizadas.fromJson(json.decode(str));

String cotizacionesRealizadasToJson(CotizacionesRealizadas data) => json.encode(data.toJson());

class CotizacionesRealizadas {
    CotizacionesRealizadas({
        this.err,
        this.mensaje,
        this.cotizacion,
    });

    bool err;
    String mensaje;
    List<Cotizacion> cotizacion;

    factory CotizacionesRealizadas.fromJson(Map<String, dynamic> json) => CotizacionesRealizadas(
        err: json["err"],
        mensaje: json["mensaje"],
        cotizacion: List<Cotizacion>.from(json["cotizacion"].map((x) => Cotizacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "cotizacion": List<dynamic>.from(cotizacion.map((x) => x.toJson())),
    };
}

class Cotizacion {
    Cotizacion({
        this.idcotizarVehiculo,
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
        this.activo,
        this.descuentosCotizacion,
        this.totalCotizacion,
        this.respuestaCotizacion,
        this.idCliente,
        this.nombre,
        this.correo,
        this.celular,
        this.nivel,
        this.uuid,
        this.fbToken,
        this.dui,
        this.ultimaConexion,
        this.idmodelo,
        this.idMarca,
    });

    String idcotizarVehiculo;
    String idUsuario;
    String modelo;
    String anio;
    String caracteristicas;
    String direccionRecogida;
    DateTime fechaRecogida;
    String horaRecogida;
    String direccionDevolucion;
    DateTime fechaDevolucion;
    String horaDevolucion;
    String activo;
    String descuentosCotizacion;
    String totalCotizacion;
    String respuestaCotizacion;
    String idCliente;
    String nombre;
    String correo;
    String celular;
    String nivel;
    String uuid;
    dynamic fbToken;
    String dui;
    dynamic ultimaConexion;
    String idmodelo;
    String idMarca;

    factory Cotizacion.fromJson(Map<String, dynamic> json) => Cotizacion(
        idcotizarVehiculo: json["idcotizarVehiculo"],
        idUsuario: json["id_usuario"],
        modelo: json["modelo"],
        anio: json["anio"],
        caracteristicas: json["caracteristicas"],
        direccionRecogida: json["direccion_recogida"],
        fechaRecogida: DateTime.parse(json["fechaRecogida"]),
        horaRecogida: json["HoraRecogida"],
        direccionDevolucion: json["direccion_devolucion"],
        fechaDevolucion: DateTime.parse(json["fechaDevolucion"]),
        horaDevolucion: json["HoraDevolucion"],
        activo: json["activo"],
        descuentosCotizacion: json["descuentosCotizacion"],
        totalCotizacion: json["totalCotizacion"],
        respuestaCotizacion: json["respuestaCotizacion"],
        idCliente: json["id_cliente"],
        nombre: json["nombre"],
        correo: json["correo"],
        celular: json["celular"],
        nivel: json["nivel"],
        uuid: json["uuid"],
        fbToken: json["fbToken"],
        dui: json["dui"],
        ultimaConexion: json["ultimaConexion"],
        idmodelo: json["idmodelo"],
        idMarca: json["id_marca"],
    );

    Map<String, dynamic> toJson() => {
        "idcotizarVehiculo": idcotizarVehiculo,
        "id_usuario": idUsuario,
        "modelo": modelo,
        "anio": anio,
        "caracteristicas": caracteristicas,
        "direccion_recogida": direccionRecogida,
        "fechaRecogida": "${fechaRecogida.year.toString().padLeft(4, '0')}-${fechaRecogida.month.toString().padLeft(2, '0')}-${fechaRecogida.day.toString().padLeft(2, '0')}",
        "HoraRecogida": horaRecogida,
        "direccion_devolucion": direccionDevolucion,
        "fechaDevolucion": "${fechaDevolucion.year.toString().padLeft(4, '0')}-${fechaDevolucion.month.toString().padLeft(2, '0')}-${fechaDevolucion.day.toString().padLeft(2, '0')}",
        "HoraDevolucion": horaDevolucion,
        "activo": activo,
        "descuentosCotizacion": descuentosCotizacion,
        "totalCotizacion": totalCotizacion,
        "respuestaCotizacion": respuestaCotizacion,
        "id_cliente": idCliente,
        "nombre": nombre,
        "correo": correo,
        "celular": celular,
        "nivel": nivel,
        "uuid": uuid,
        "fbToken": fbToken,
        "dui": dui,
        "ultimaConexion": ultimaConexion,
        "idmodelo": idmodelo,
        "id_marca": idMarca,
    };
}
