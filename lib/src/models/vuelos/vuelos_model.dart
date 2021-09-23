// To parse this JSON data, do
//
//     final vuelosModel = vuelosModelFromJson(jsonString);

import 'dart:convert';

VuelosModel vuelosModelFromJson(String str) => VuelosModel.fromJson(json.decode(str));

String vuelosModelToJson(VuelosModel data) => json.encode(data.toJson());

class VuelosModel {
    VuelosModel({
        this.err,
        this.mensaje,
        this.promociones,
    });

    bool err;
    String mensaje;
    List<Promocione> promociones;

    factory VuelosModel.fromJson(Map<String, dynamic> json) => VuelosModel(
        err: json["err"],
        mensaje: json["mensaje"],
        promociones: List<Promocione>.from(json["promociones"].map((x) => Promocione.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "promociones": List<dynamic>.from(promociones.map((x) => x.toJson())),
    };
}

class Promocione {
    Promocione({
        this.idpromocionVuelo,
        this.idaerolineaFk,
        this.idclaseFk,
        this.nombrePromocion,
        this.paisPromocion,
        this.lugarSalidaPromocion,
        this.precioPromocion,
        this.fechaDisponiblePromocion,
        this.descripcionPromocion,
        this.activo,
        this.idaerolinea,
        this.idalianza,
        this.nombreAerolinea,
        this.sitioWeb,
        this.telefonoContacto,
        this.idclase,
        this.nombreClase,
        this.descripcion,
        this.foto,
        this.galeria,
    });

    String idpromocionVuelo;
    String idaerolineaFk;
    String idclaseFk;
    String nombrePromocion;
    String paisPromocion;
    String lugarSalidaPromocion;
    String precioPromocion;
    String fechaDisponiblePromocion;
    String descripcionPromocion;
    String activo;
    String idaerolinea;
    String idalianza;
    String nombreAerolinea;
    String sitioWeb;
    String telefonoContacto;
    String idclase;
    String nombreClase;
    String descripcion;
    String foto;
    List<String> galeria;

    factory Promocione.fromJson(Map<String, dynamic> json) => Promocione(
        idpromocionVuelo: json["idpromocion_vuelo"],
        idaerolineaFk: json["idaerolineaFK"],
        idclaseFk: json["idclaseFK"],
        nombrePromocion: json["nombre_promocion"],
        paisPromocion: json["pais_promocion"],
        lugarSalidaPromocion: json["lugarSalida_promocion"],
        precioPromocion: json["precio_promocion"],
        fechaDisponiblePromocion: json["fechaDisponible_promocion"],
        descripcionPromocion: json["descripcion_promocion"],
        activo: json["activo"],
        idaerolinea: json["idaerolinea"],
        idalianza: json["idalianza"],
        nombreAerolinea: json["nombre_aerolinea"],
        sitioWeb: json["sitioWeb"],
        telefonoContacto: json["telefonoContacto"],
        idclase: json["idclase"],
        nombreClase: json["nombre_clase"],
        descripcion: json["descripcion"],
        foto: json["foto"],
        galeria: List<String>.from(json["galeria"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "idpromocion_vuelo": idpromocionVuelo,
        "idaerolineaFK": idaerolineaFk,
        "idclaseFK": idclaseFk,
        "nombre_promocion": nombrePromocion,
        "pais_promocion": paisPromocion,
        "lugarSalida_promocion": lugarSalidaPromocion,
        "precio_promocion": precioPromocion,
        "fechaDisponible_promocion": fechaDisponiblePromocion,
        "descripcion_promocion": descripcionPromocion,
        "activo": activo,
        "idaerolinea": idaerolinea,
        "idalianza": idalianza,
        "nombre_aerolinea": nombreAerolinea,
        "sitioWeb": sitioWeb,
        "telefonoContacto": telefonoContacto,
        "idclase": idclase,
        "nombre_clase": nombreClase,
        "descripcion": descripcion,
        "foto": foto,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
    };
}
