// To parse this JSON data, do
//
//     final documentosModel = documentosModelFromJson(jsonString);

import 'dart:convert';

List<DocumentosModel> documentosModelFromJson(String str) => List<DocumentosModel>.from(json.decode(str).map((x) => DocumentosModel.fromJson(x)));

String documentosModelToJson(List<DocumentosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DocumentosModel {
    DocumentosModel({
        this.idFoto,
        this.tipo,
        this.identificador,
        this.fotoPath,
        this.activo,
        this.nombreFoto,
    });

    String idFoto;
    String tipo;
    String identificador;
    String fotoPath;
    String activo;
    String nombreFoto;

    factory DocumentosModel.fromJson(Map<String, dynamic> json) => DocumentosModel(
        idFoto: json["id_foto"],
        tipo: json["tipo"],
        identificador: json["identificador"],
        fotoPath: json["foto_path"],
        activo: json["activo"],
        nombreFoto: json["nombre_foto"],
    );

    Map<String, dynamic> toJson() => {
        "id_foto": idFoto,
        "tipo": tipo,
        "identificador": identificador,
        "foto_path": fotoPath,
        "activo": activo,
        "nombre_foto": nombreFoto,
    };
}
