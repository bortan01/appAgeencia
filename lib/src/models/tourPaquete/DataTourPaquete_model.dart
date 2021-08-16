// To parse this JSON data, do
//
//     final dataTourPaqueteModel = dataTourPaqueteModelFromJson(jsonString);

import 'dart:convert';

List<DataTourPaqueteModel> dataTourPaqueteModelFromJson(String str) => List<DataTourPaqueteModel>.from(json.decode(str).map((x) => DataTourPaqueteModel.fromJson(x)));

String dataTourPaqueteModelToJson(List<DataTourPaqueteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataTourPaqueteModel {
    DataTourPaqueteModel({
        this.idTours,
        this.nombreTours,
        this.start,
        this.end,
        this.lugarSalida,
        this.precio,
        this.incluye,
        this.noIncluye,
        this.requisitos,
        this.promociones,
        this.descripcionTur,
        this.cuposDisponibles,
        this.nombreEncargado,
        this.estado,
        this.aprobado,
        this.tipo,
        this.descripcionForApp,
        this.foto,
        this.galeria,
        this.transporte,
        this.sitiosTuristicos,
        this.serviciosAdicionales,
    });

    String idTours;
    String nombreTours;
    DateTime start;
    DateTime end;
    List<String> lugarSalida;
    String precio;
    List<String> incluye;
    List<String> noIncluye;
    List<String> requisitos;
    List<Promocione> promociones;
    String descripcionTur;
    String cuposDisponibles;
    dynamic nombreEncargado;
    String estado;
    String aprobado;
    String tipo;
    String descripcionForApp;
    String foto;
    List<String> galeria;
    Transporte transporte;
    List<SitiosTuristico> sitiosTuristicos;
    List<ServiciosAdicionale> serviciosAdicionales;

    factory DataTourPaqueteModel.fromJson(Map<String, dynamic> json) => DataTourPaqueteModel(
        idTours: json["id_tours"],
        nombreTours: json["nombreTours"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        lugarSalida: List<String>.from(json["lugar_salida"].map((x) => x)),
        precio: json["precio"],
        incluye: List<String>.from(json["incluye"].map((x) => x)),
        noIncluye: List<String>.from(json["no_incluye"].map((x) => x)),
        requisitos: List<String>.from(json["requisitos"].map((x) => x)),
        promociones: List<Promocione>.from(json["promociones"].map((x) => Promocione.fromJson(x))),
        descripcionTur: json["descripcion_tur"],
        cuposDisponibles: json["cupos_disponibles"],
        nombreEncargado: json["nombre_encargado"],
        estado: json["estado"],
        aprobado: json["aprobado"],
        tipo: json["tipo"],
        descripcionForApp: json["descripcionForApp"],
        foto: json["foto"],
        galeria: List<String>.from(json["galeria"].map((x) => x)),
        transporte: json["transporte"] == null ? null : Transporte.fromJson(json["transporte"]),
        sitiosTuristicos: List<SitiosTuristico>.from(json["sitiosTuristicos"].map((x) => SitiosTuristico.fromJson(x))),
        serviciosAdicionales: List<ServiciosAdicionale>.from(json["serviciosAdicionales"].map((x) => ServiciosAdicionale.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_tours": idTours,
        "nombreTours": nombreTours,
        "start": "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "end": "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
        "lugar_salida": List<dynamic>.from(lugarSalida.map((x) => x)),
        "precio": precio,
        "incluye": List<dynamic>.from(incluye.map((x) => x)),
        "no_incluye": List<dynamic>.from(noIncluye.map((x) => x)),
        "requisitos": List<dynamic>.from(requisitos.map((x) => x)),
        "promociones": List<dynamic>.from(promociones.map((x) => x.toJson())),
        "descripcion_tur": descripcionTur,
        "cupos_disponibles": cuposDisponibles,
        "nombre_encargado": nombreEncargado,
        "estado": estado,
        "aprobado": aprobado,
        "tipo": tipo,
        "descripcionForApp": descripcionForApp,
        "foto": foto,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
        "transporte": transporte == null ? null : transporte.toJson(),
        "sitiosTuristicos": List<dynamic>.from(sitiosTuristicos.map((x) => x.toJson())),
        "serviciosAdicionales": List<dynamic>.from(serviciosAdicionales.map((x) => x.toJson())),
    };
}

class Promocione {
    Promocione({
        this.titulo,
        this.asiento,
        this.pasaje,
    });

    String titulo;
    String asiento;
    String pasaje;

    factory Promocione.fromJson(Map<String, dynamic> json) => Promocione(
        titulo: json["titulo"],
        asiento: json["asiento"],
        pasaje: json["pasaje"],
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "asiento": asiento,
        "pasaje": pasaje,
    };
}

class ServiciosAdicionale {
    ServiciosAdicionale({
        this.idServicios,
        this.nombreServicio,
        this.descripcionServicio,
        this.galeria,
    });

    String idServicios;
    String nombreServicio;
    String descripcionServicio;
    List<String> galeria;

    factory ServiciosAdicionale.fromJson(Map<String, dynamic> json) => ServiciosAdicionale(
        idServicios: json["id_servicios"],
        nombreServicio: json["nombre_servicio"],
        descripcionServicio: json["descripcion_servicio"],
        galeria: List<String>.from(json["galeria"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id_servicios": idServicios,
        "nombre_servicio": nombreServicio,
        "descripcion_servicio": descripcionServicio,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
    };
}

class SitiosTuristico {
    SitiosTuristico({
        this.idSitioTuristico,
        this.nombreSitio,
        this.descripcionSitio,
        this.galeria,
    });

    String idSitioTuristico;
    String nombreSitio;
    String descripcionSitio;
    List<String> galeria;

    factory SitiosTuristico.fromJson(Map<String, dynamic> json) => SitiosTuristico(
        idSitioTuristico: json["id_sitio_turistico"],
        nombreSitio: json["nombre_sitio"],
        descripcionSitio: json["descripcion_sitio"],
        galeria: List<String>.from(json["galeria"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id_sitio_turistico": idSitioTuristico,
        "nombre_sitio": nombreSitio,
        "descripcion_sitio": descripcionSitio,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
    };
}

class Transporte {
    Transporte({
        this.asientosDeshabilitados,
        this.nombreServicio,
        this.filaTrasera,
        this.asientoDerecho,
        this.asientoIzquierdo,
        this.filas,
        this.ocupados,
    });

    String asientosDeshabilitados;
    String nombreServicio;
    String filaTrasera;
    String asientoDerecho;
    String asientoIzquierdo;
    String filas;
    List<String> ocupados;

    factory Transporte.fromJson(Map<String, dynamic> json) => Transporte(
        asientosDeshabilitados: json["asientos_deshabilitados"],
        nombreServicio: json["nombre_servicio"],
        filaTrasera: json["fila_trasera"],
        asientoDerecho: json["asiento_derecho"],
        asientoIzquierdo: json["asiento_izquierdo"],
        filas: json["filas"],
        ocupados: List<String>.from(json["ocupados"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "asientos_deshabilitados": asientosDeshabilitados,
        "nombre_servicio": nombreServicio,
        "fila_trasera": filaTrasera,
        "asiento_derecho": asientoDerecho,
        "asiento_izquierdo": asientoIzquierdo,
        "filas": filas,
        "ocupados": List<dynamic>.from(ocupados.map((x) => x)),
    };
}
