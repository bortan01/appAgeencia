// To parse this JSON data, do
//
//     final tipoVehiculo = tipoVehiculoFromJson(jsonString);

import 'dart:convert';

TipoVehiculo tipoVehiculoFromJson(String str) => TipoVehiculo.fromJson(json.decode(str));

String tipoVehiculoToJson(TipoVehiculo data) => json.encode(data.toJson());

class TipoVehiculo {
    TipoVehiculo({
        this.err,
        this.mensaje,
        this.modelo,
    });

    bool err;
    String mensaje;
    List<ModeloVehiculo> modelo;

    factory TipoVehiculo.fromJson(Map<String, dynamic> json) => TipoVehiculo(
        err: json["err"],
        mensaje: json["mensaje"],
        modelo: List<ModeloVehiculo>.from(json["modelo"].map((x) => ModeloVehiculo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "modelo": List<dynamic>.from(modelo.map((x) => x.toJson())),
    };
}

class ModeloVehiculo {
    ModeloVehiculo({
        this.idmodelo,
        this.idMarca,
        this.modelo,
        this.activo,
    });

    String idmodelo;
    String idMarca;
    String modelo;
    String activo;

    factory ModeloVehiculo.fromJson(Map<String, dynamic> json) => ModeloVehiculo(
        idmodelo: json["idmodelo"],
        idMarca: json["id_marca"],
        modelo: json["modelo"],
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "idmodelo": idmodelo,
        "id_marca": idMarca,
        "modelo": modelo,
        "activo": activo,
    };
}
