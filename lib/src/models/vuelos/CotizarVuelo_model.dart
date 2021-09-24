// To parse this JSON data, do
//
//     final cotizarVueloModel = cotizarVueloModelFromJson(jsonString);

import 'dart:convert';

CotizarVueloModel cotizarVueloModelFromJson(String str) => CotizarVueloModel.fromJson(json.decode(str));

String cotizarVueloModelToJson(CotizarVueloModel data) => json.encode(data.toJson());

class CotizarVueloModel {
    CotizarVueloModel({
        this.aerolineas,
        this.clases,
        this.tiposViajes,
        this.condiciones,
    });

    List<Aerolinea> aerolineas;
    List<Clase> clases;
    List<TiposViaje> tiposViajes;
    List<Condicione> condiciones;

    factory CotizarVueloModel.fromJson(Map<String, dynamic> json) => CotizarVueloModel(
        aerolineas: List<Aerolinea>.from(json["aerolineas"].map((x) => Aerolinea.fromJson(x))),
        clases: List<Clase>.from(json["clases"].map((x) => Clase.fromJson(x))),
        tiposViajes: List<TiposViaje>.from(json["tiposViajes"].map((x) => TiposViaje.fromJson(x))),
        condiciones: List<Condicione>.from(json["condiciones"].map((x) => Condicione.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "aerolineas": List<dynamic>.from(aerolineas.map((x) => x.toJson())),
        "clases": List<dynamic>.from(clases.map((x) => x.toJson())),
        "tiposViajes": List<dynamic>.from(tiposViajes.map((x) => x.toJson())),
        "condiciones": List<dynamic>.from(condiciones.map((x) => x.toJson())),
    };
}

class Aerolinea {
    Aerolinea({
        this.idaerolinea,
        this.idalianza,
        this.nombreAerolinea,
        this.activo,
        this.sitioWeb,
        this.telefonoContacto,
        this.nombreAlianza,
        this.sitioWebAlianza,
        this.telefonoContactoAlianza,
    });

    String idaerolinea;
    String idalianza;
    String nombreAerolinea;
    String activo;
    String sitioWeb;
    String telefonoContacto;
    String nombreAlianza;
    String sitioWebAlianza;
    String telefonoContactoAlianza;

    factory Aerolinea.fromJson(Map<String, dynamic> json) => Aerolinea(
        idaerolinea: json["idaerolinea"],
        idalianza: json["idalianza"],
        nombreAerolinea: json["nombre_aerolinea"],
        activo: json["activo"],
        sitioWeb: json["sitioWeb"],
        telefonoContacto: json["telefonoContacto"],
        nombreAlianza: json["nombre_alianza"],
        sitioWebAlianza: json["sitioWeb_alianza"],
        telefonoContactoAlianza: json["telefonoContacto_alianza"],
    );

    Map<String, dynamic> toJson() => {
        "idaerolinea": idaerolinea,
        "idalianza": idalianza,
        "nombre_aerolinea": nombreAerolinea,
        "activo": activo,
        "sitioWeb": sitioWeb,
        "telefonoContacto": telefonoContacto,
        "nombre_alianza": nombreAlianza,
        "sitioWeb_alianza": sitioWebAlianza,
        "telefonoContacto_alianza": telefonoContactoAlianza,
    };
}

class Clase {
    Clase({
        this.idclase,
        this.nombreClase,
        this.descripcion,
        this.activo,
    });

    String idclase;
    String nombreClase;
    String descripcion;
    String activo;

    factory Clase.fromJson(Map<String, dynamic> json) => Clase(
        idclase: json["idclase"],
        nombreClase: json["nombre_clase"],
        descripcion: json["descripcion"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "idclase": idclase,
        "nombre_clase": nombreClase,
        "descripcion": descripcion,
        "activo": activo,
    };
}

class Condicione {
    Condicione({
        this.idinfoAdicional,
        this.condiciones,
        this.activo,
    });

    String idinfoAdicional;
    String condiciones;
    String activo;

    factory Condicione.fromJson(Map<String, dynamic> json) => Condicione(
        idinfoAdicional: json["idinfo_adicional"],
        condiciones: json["condiciones"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "idinfo_adicional": idinfoAdicional,
        "condiciones": condiciones,
        "activo": activo,
    };
}

class TiposViaje {
    TiposViaje({
        this.idtipoViaje,
        this.nombreTipoviaje,
        this.descripcion,
        this.activo,
    });

    String idtipoViaje;
    String nombreTipoviaje;
    String descripcion;
    String activo;

    factory TiposViaje.fromJson(Map<String, dynamic> json) => TiposViaje(
        idtipoViaje: json["idtipo_viaje"],
        nombreTipoviaje: json["nombre_tipoviaje"],
        descripcion: json["descripcion"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "idtipo_viaje": idtipoViaje,
        "nombre_tipoviaje": nombreTipoviaje,
        "descripcion": descripcion,
        "activo": activo,
    };
}
