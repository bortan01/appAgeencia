// To parse this JSON data, do
//
//     final responseUpdateModel = responseUpdateModelFromJson(jsonString);

import 'dart:convert';

ResponseUpdateModel responseUpdateModelFromJson(String str) => ResponseUpdateModel.fromJson(json.decode(str));

String responseUpdateModelToJson(ResponseUpdateModel data) => json.encode(data.toJson());

class ResponseUpdateModel {
  ResponseUpdateModel({
    this.err,
    this.mensaje,
    this.usuario,
  });

  bool err;
  String mensaje;
  Usuario usuario;

  factory ResponseUpdateModel.fromJson(Map<String, dynamic> json) => ResponseUpdateModel(
        err: json["err"],
        mensaje: json["mensaje"],
        usuario: Usuario.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "usuario": usuario.toJson(),
      };
}

class Usuario {
  Usuario({
    this.idCliente,
    this.correo,
    this.dui,
    this.nombre,
    this.celular,
  });

  String idCliente;
  String correo;
  String dui;
  String nombre;
  String celular;
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idCliente: json["id_cliente"],
        correo: json["correo"],
        dui: json["dui"],
        nombre: json["nombre"],
        celular: json["celular"],
      );

  Map<String, dynamic> toJson() => {
        "id_cliente": idCliente,
        "correo": correo,
        "dui": dui,
        "nombre": nombre,
        "celular": celular,
      };
}
