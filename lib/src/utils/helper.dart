import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String necesario = "campo necesario";
String transformarFoto(url) {
  //replace substring of the given string
  return url.replaceAll(
      "http://localhost/API-REST-PHP/", "http://10.0.2.2:80/API-REST-PHP/");
}

String isNumeric(String s) {
  if (s.isEmpty) return null;
  final n = num.tryParse(s);
  return (n == null) ? "solo numeros" : null;
}

String isNumericRequired(String s) {
  if (s.isEmpty) return necesario;
  final n = num.tryParse(s);
  return (n == null) ? "solo numeros" : null;
}

String minLength(String s, int min) {
  if (s.isEmpty) return null;
  return (s.length < min) ? "Longitud debe ser menor que $min" : null;
}

String minLengthRequired(String s, int min) {
  if (s.isEmpty) return necesario;
  return (s.length < min) ? "Longitud debe ser menor que $min" : null;
}

String maxLength(String s, int max) {
  if (s.isEmpty) return null;
  return (s.length > max) ? "Longitud debe ser mayor que $max" : null;
}

String maxLengthRequired(String s, int max) {
  if (s.isEmpty) return necesario;
  return (s.length < max) ? "Longitud debe ser mayor que $max" : null;
}

String betweenLength(String s, int max, int min) {
  if ((s).trim().isEmpty) return null;
  if ((s).trim().length > max) return "Longitud maxima ${max.toString()}";
  if ((s).trim().length < min) return "Longitud minima ${min.toString()}";
  return null;
}

String betweenLengthRequired(String s, int max, int min) {
  if ((s).trim().isEmpty) return necesario;
  if ((s).trim().length > max) return "Longitud maxima ${max.toString()}";
  if ((s).trim().length < min) return "Longitud minima ${min.toString()}";
  return null;
}

String isMail(String s) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(s);
  if (s.isEmpty) return null;
  return (!emailValid) ? "Ingrese un Email valido" : null;
}

String isMailRequired(String s) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(s);
  if (s.isEmpty) return necesario;
  return (!emailValid) ? "Ingrese un Email valido" : null;
}

String repeatPassword(String password, String repetida) {
  if ((repetida).trim().isEmpty) return necesario;
  return !(password == repetida) ? "Password no coinciden" : null;
}

void mostrarMensanjeError(BuildContext context, String mensaje) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Oops",
    desc: mensaje,
    buttons: [
      DialogButton(
        child: Text(
          "Cerrar",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      )
    ],
  ).show();
}
