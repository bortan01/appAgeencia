// To parse this JSON data, do
//
//     final imagenModel = imagenModelFromJson(jsonString);

import 'dart:convert';

ImagenModel imagenModelFromJson(String str) => ImagenModel.fromJson(json.decode(str));

String imagenModelToJson(ImagenModel data) => json.encode(data.toJson());

class ImagenModel {
    ImagenModel({
        this.identificador,
        this.tipo,
        this.fotoUrl,
    });

    String identificador;
    String tipo;
    String fotoUrl;

    factory ImagenModel.fromJson(Map<String, dynamic> json) => ImagenModel(
        identificador: json["identificador"],
        tipo: json["tipo"],
        fotoUrl: json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "identificador": identificador,
        "tipo": tipo,
        "fotoUrl": fotoUrl,
    };
}
