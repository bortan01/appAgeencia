// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.correo,
    this.nombre,
    this.nivel,
    this.password,
    this.celular,
    this.dui,
  });

  String correo;
  String nombre;
  String nivel;
  String password;
  String celular;
  String dui;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        correo: json["correo"],
        nombre: json["nombre"],
        nivel: json["nivel"],
        password: json["password"],
        celular: json["celular"],
        dui: json["dui"],
      );

  Map<String, dynamic> toJson() => {
        "correo": correo,
        "nombre": nombre,
        "nivel": nivel,
        "password": password,
        "celular": celular,
        "dui": dui,
      };
}
