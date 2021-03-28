// To parse this JSON data, do
//
//     final wompiModel = wompiModelFromJson(jsonString);

import 'dart:convert';

WompiModel wompiModelFromJson(String str) => WompiModel.fromJson(json.decode(str));

String wompiModelToJson(WompiModel data) => json.encode(data.toJson());

class WompiModel {
    WompiModel({
        this.err,
        this.idEnlace,
        this.urlQrCodeEnlace,
        this.urlEnlace,
    });

    bool err;
    int idEnlace;
    String urlQrCodeEnlace;
    String urlEnlace;

    factory WompiModel.fromJson(Map<String, dynamic> json) => WompiModel(
        err: json["err"],
        idEnlace: json["idEnlace"],
        urlQrCodeEnlace: json["urlQrCodeEnlace"],
        urlEnlace: json["urlEnlace"],
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "idEnlace": idEnlace,
        "urlQrCodeEnlace": urlQrCodeEnlace,
        "urlEnlace": urlEnlace,
    };
}
