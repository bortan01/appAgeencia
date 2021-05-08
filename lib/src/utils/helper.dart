import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

String necesario = "campo necesario";
String transformarFoto(url) {
  //replace substring of the given string
  return url.replaceAll("http://localhost/API-REST-PHP/", "http://10.0.2.2:80/API-REST-PHP/");
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
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s);
  if (s.isEmpty) return null;
  return (!emailValid) ? "Ingrese un Email valido" : null;
}

String isMailRequired(String s) {
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s);
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

void mostrarMensajeOk(BuildContext context, String mensaje) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Exito",
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

//REDIRECCIONA SOLAMENTE AL HOME
void mensanjeOkRedireccionar(BuildContext context, String mensaje, String ruta) {
  Alert(
    context: context,
    type: AlertType.success,
    title: "Listo",
    desc: mensaje,
    buttons: [
      DialogButton(
        child: Text(
          "ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => Home()), ModalRoute.withName("home")),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      )
    ],
  ).show();
}

transformer<T>(T Function(Map<String, dynamic> json) fromJson) =>
    StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
        final snaps = data.docs.map((doc) => doc.data()).toList();
        final chats = snaps.map((json) => fromJson(json)).toList();

        sink.add(chats);
      },
    );

redireccionar(BuildContext context, String url) async {
  // url = 'https://www.marca.com/';
  if (await canLaunch(url)) {
    await launch(url);
    Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
  } else {
    throw 'Could not launch $url';
  }
}

Widget noData() {
  return Container(child: Center(child: Text("No hay datos que mostrar")));
}

Widget waitingData() {
  return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
}

TextStyle titulo2() {
  return TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue, fontSize: 16.0);
}

Text crearTitulo(String tiulo) {
  return Text(
    tiulo,
    textAlign: TextAlign.center,
    style: titulo2(),
  );
}

posterTitulo({@required BuildContext context, @required String title}) {
  return Container(
    child: new Text(
      title,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(color: Colors.lightBlue, fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

String transformarFecha(DateTime fecha) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(fecha);
}

String transformarFechaAndHora(DateTime fecha) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');
  return formatter.format(fecha);
}
String transformarHora(DateTime fecha) {
  final DateFormat formatter = DateFormat('hh:mm a');
  return formatter.format(fecha);
}
