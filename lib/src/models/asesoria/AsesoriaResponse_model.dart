// To parse this JSON data, do
//
//     final asesoriaResponseModel = asesoriaResponseModelFromJson(jsonString);

import 'dart:convert';

AsesoriaResponseModel asesoriaResponseModelFromJson(String str) => AsesoriaResponseModel.fromJson(json.decode(str));

String asesoriaResponseModelToJson(AsesoriaResponseModel data) => json.encode(data.toJson());

class AsesoriaResponseModel {
    AsesoriaResponseModel({
        this.err,
        this.mensaje,
        this.citaId,
    });

    bool err;
    String mensaje;
    int citaId;

    factory AsesoriaResponseModel.fromJson(Map<String, dynamic> json) => AsesoriaResponseModel(
        err: json["err"],
        mensaje: json["mensaje"],
        citaId: json["cita_id"],
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "cita_id": citaId,
    };
}
