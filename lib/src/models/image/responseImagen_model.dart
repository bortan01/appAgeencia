// To parse this JSON data, do
//
//     final imagenResponse = imagenResponseFromJson(jsonString);

import 'dart:convert';

ImagenResponse imagenResponseFromJson(String str) => ImagenResponse.fromJson(json.decode(str));

String imagenResponseToJson(ImagenResponse data) => json.encode(data.toJson());

class ImagenResponse {
    ImagenResponse({
        this.err,
        this.mensaje,
        this.nombre,
        this.path,
        this.idFoto,
    });

    bool err;
    String mensaje;
    String nombre;
    String path;
    int idFoto;

    factory ImagenResponse.fromJson(Map<String, dynamic> json) => ImagenResponse(
        err: json["err"],
        mensaje: json["mensaje"],
        nombre: json["nombre"],
        path: json["path"],
        idFoto: json["id_foto"],
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "nombre": nombre,
        "path": path,
        "id_foto": idFoto,
    };
}
