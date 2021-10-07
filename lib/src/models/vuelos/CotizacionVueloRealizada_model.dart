// To parse this JSON data, do
//
//     final cotizacionVueloRealizadaModel = cotizacionVueloRealizadaModelFromJson(jsonString);

import 'dart:convert';

CotizacionVueloRealizadaModel cotizacionVueloRealizadaModelFromJson(String str) => CotizacionVueloRealizadaModel.fromJson(json.decode(str));

String cotizacionVueloRealizadaModelToJson(CotizacionVueloRealizadaModel data) => json.encode(data.toJson());

class CotizacionVueloRealizadaModel {
    CotizacionVueloRealizadaModel({
        this.err,
        this.mensaje,
        this.informacion,
    });

    bool err;
    String mensaje;
    List<Informacion> informacion;

    factory CotizacionVueloRealizadaModel.fromJson(Map<String, dynamic> json) => CotizacionVueloRealizadaModel(
        err: json["err"],
        mensaje: json["mensaje"],
        informacion: List<Informacion>.from(json["informacion"].map((x) => Informacion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "informacion": List<dynamic>.from(informacion.map((x) => x.toJson())),
    };
}

class Informacion {
    Informacion({
        this.idCotizacion,
        this.idCliente,
        this.idaerolinea,
        this.idclase,
        this.idtipoViaje,
        this.opcAvanzadas,
        this.total,
        this.descuentos,
        this.activo,
        this.ciudadPartida,
        this.fechaPartida,
        this.horaPartida,
        this.ciudadLlegada,
        this.horaLlegada,
        this.fechaLlegada,
        this.adultos,
        this.ninos,
        this.bebes,
        this.maletas,
        this.detallePasajero,
        this.idalianza,
        this.nombreAerolinea,
        this.sitioWeb,
        this.telefonoContacto,
        this.nombreAlianza,
        this.sitioWebAlianza,
        this.telefonoContactoAlianza,
        this.nombreClase,
        this.descripcion,
        this.nombreTipoviaje,
        this.nombre,
        this.correo,
        this.celular,
        this.nivel,
        this.uuid,
        this.fbToken,
        this.dui,
        this.ultimaConexion,
    });

    String idCotizacion;
    String idCliente;
    String idaerolinea;
    String idclase;
    String idtipoViaje;
    List<String> opcAvanzadas;
    String total;
    String descuentos;
    String activo;
    String ciudadPartida;
    String fechaPartida;
    String horaPartida;
    String ciudadLlegada;
    String horaLlegada;
    String fechaLlegada;
    String adultos;
    String ninos;
    String bebes;
    String maletas;
    String detallePasajero;
    String idalianza;
    String nombreAerolinea;
    String sitioWeb;
    String telefonoContacto;
    String nombreAlianza;
    String sitioWebAlianza;
    String telefonoContactoAlianza;
    String nombreClase;
    String descripcion;
    String nombreTipoviaje;
    String nombre;
    String correo;
    String celular;
    String nivel;
    String uuid;
    dynamic fbToken;
    String dui;
    DateTime ultimaConexion;

    factory Informacion.fromJson(Map<String, dynamic> json) => Informacion(
        idCotizacion: json["id_cotizacion"],
        idCliente: json["id_cliente"],
        idaerolinea: json["idaerolinea"],
        idclase: json["idclase"],
        idtipoViaje: json["idtipo_viaje"],
        opcAvanzadas: List<String>.from(json["opc_avanzadas"].map((x) => x)),
        total: json["total"],
        descuentos: json["descuentos"],
        activo: json["activo"],
        ciudadPartida: json["ciudad_partida"],
        fechaPartida: json["fechaPartida"],
        horaPartida: json["HoraPartida"],
        ciudadLlegada: json["ciudad_llegada"],
        horaLlegada: json["HoraLlegada"],
        fechaLlegada: json["fechaLlegada"],
        adultos: json["adultos"],
        ninos: json["ninos"],
        bebes: json["bebes"],
        maletas: json["maletas"],
        detallePasajero: json["detallePasajero"],
        idalianza: json["idalianza"],
        nombreAerolinea: json["nombre_aerolinea"],
        sitioWeb: json["sitioWeb"],
        telefonoContacto: json["telefonoContacto"],
        nombreAlianza: json["nombre_alianza"],
        sitioWebAlianza: json["sitioWeb_alianza"],
        telefonoContactoAlianza: json["telefonoContacto_alianza"],
        nombreClase: json["nombre_clase"],
        descripcion: json["descripcion"],
        nombreTipoviaje: json["nombre_tipoviaje"],
        nombre: json["nombre"],
        correo: json["correo"],
        celular: json["celular"],
        nivel: json["nivel"],
        uuid: json["uuid"],
        fbToken: json["fbToken"],
        dui: json["dui"],
        ultimaConexion: DateTime.parse(json["ultimaConexion"]),
    );

    Map<String, dynamic> toJson() => {
        "id_cotizacion": idCotizacion,
        "id_cliente": idCliente,
        "idaerolinea": idaerolinea,
        "idclase": idclase,
        "idtipo_viaje": idtipoViaje,
        "opc_avanzadas": List<dynamic>.from(opcAvanzadas.map((x) => x)),
        "total": total,
        "descuentos": descuentos,
        "activo": activo,
        "ciudad_partida": ciudadPartida,
        "fechaPartida": fechaPartida,
        "HoraPartida": horaPartida,
        "ciudad_llegada": ciudadLlegada,
        "HoraLlegada": horaLlegada,
        "fechaLlegada": fechaLlegada,
        "adultos": adultos,
        "ninos": ninos,
        "bebes": bebes,
        "maletas": maletas,
        "detallePasajero": detallePasajero,
        "idalianza": idalianza,
        "nombre_aerolinea": nombreAerolinea,
        "sitioWeb": sitioWeb,
        "telefonoContacto": telefonoContacto,
        "nombre_alianza": nombreAlianza,
        "sitioWeb_alianza": sitioWebAlianza,
        "telefonoContacto_alianza": telefonoContactoAlianza,
        "nombre_clase": nombreClase,
        "descripcion": descripcion,
        "nombre_tipoviaje": nombreTipoviaje,
        "nombre": nombre,
        "correo": correo,
        "celular": celular,
        "nivel": nivel,
        "uuid": uuid,
        "fbToken": fbToken,
        "dui": dui,
        "ultimaConexion": ultimaConexion.toIso8601String(),
    };
}
