// To parse this JSON data, do
//
//     final informacionAdicional = informacionAdicionalFromJson(jsonString);

import 'dart:convert';

InformacionAdicional informacionAdicionalFromJson(String str) => InformacionAdicional.fromJson(json.decode(str));

String informacionAdicionalToJson(InformacionAdicional data) => json.encode(data.toJson());

class InformacionAdicional {
    InformacionAdicional({
        this.sitiosTuristicos,
        this.serviciosAdicionales,
    });

    List<SitiosTuristico> sitiosTuristicos;
    List<ServiciosAdicionale> serviciosAdicionales;

    factory InformacionAdicional.fromJson(Map<String, dynamic> json) => InformacionAdicional(
        sitiosTuristicos: List<SitiosTuristico>.from(json["sitiosTuristicos"].map((x) => SitiosTuristico.fromJson(x))),
        serviciosAdicionales: List<ServiciosAdicionale>.from(json["serviciosAdicionales"].map((x) => ServiciosAdicionale.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sitiosTuristicos": List<dynamic>.from(sitiosTuristicos.map((x) => x.toJson())),
        "serviciosAdicionales": List<dynamic>.from(serviciosAdicionales.map((x) => x.toJson())),
    };
}

class ServiciosAdicionale {
    ServiciosAdicionale({
        this.idServicios,
        this.nombreServicio,
        this.descripcionServicio,
        this.galeria,
    });

    int idServicios;
    String nombreServicio;
    String descripcionServicio;
    List<String> galeria;

    factory ServiciosAdicionale.fromJson(Map<String, dynamic> json) => ServiciosAdicionale(
        idServicios: int.parse( json["id_servicios"]),
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

    int idSitioTuristico;
    String nombreSitio;
    String descripcionSitio;
    List<String> galeria;

    factory SitiosTuristico.fromJson(Map<String, dynamic> json) => SitiosTuristico(
        idSitioTuristico: int.parse(json["id_sitio_turistico"]),
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
