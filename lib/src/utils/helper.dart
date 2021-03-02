import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String transformarFoto(url) {
  //replace substring of the given string
  return url.replaceAll(
      "http://localhost/API-REST-PHP/", "http://10.0.2.2:80/API-REST-PHP/");
}

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  return (n == null) ? false : true;
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
