import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/image/responseImagen_model.dart';
// import 'package:peliculas/src/models/image/imagen_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class SubirImagenes extends StatefulWidget {
  @override
  _SubirImagenesState createState() => _SubirImagenesState();
}

class _SubirImagenesState extends State<SubirImagenes> {
  final picker = ImagePicker();
  File _foto;
  // final _imagenModel = new ImagenModel();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final UserServices _userServices = new UserServices();
  final PreferenciasUsuario _preferenciasUsuario = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Seleccione su foto'),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.photo_size_select_actual), onPressed: _seleccionarFoto),
            new IconButton(icon: new Icon(Icons.camera), onPressed: _tomarFoto),
          ],
        ),
        body: new SingleChildScrollView(
            child: new Container(
          padding: EdgeInsets.all(15.0),
          child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  _mostrarFoto(),
                  crearBotton(context),
                ],
              )),
        )));
  }

  void _seleccionarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _foto = (pickedFile != null) ? File(pickedFile.path) : null;
    setState(() {});
  }

  void _tomarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _foto = (pickedFile != null) ? File(pickedFile.path) : null;
    setState(() {});
  }

  Widget _mostrarFoto() {
    if (_foto != null) {
      return Center(
        //pregunta si existe la imagen
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Image.file(_foto, height: 300.0, fit: BoxFit.cover),
          ),
        ),
      );
    }
    if (_preferenciasUsuario.foto != '') {
      return Container(

          ///esto es para evitar problema si no existe el id del producto, como cuando no se a creado
          child: new Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
              child: FadeInImage(
            placeholder: AssetImage("assets/gif/loading.gif"),
            image: NetworkImage(helper.transformarFoto(_preferenciasUsuario.foto)),
          )),
        ),
      ));
    }
    return Center(
        //pregunta si existe la imagen
        child: Image(image: AssetImage('assets/img/avatar.png'), height: 300.0, fit: BoxFit.cover));
  }

  crearBotton(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () => submit(context),
      icon: new Icon(Icons.save),
      label: Text("guardar"),
      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
    );
  }

  submit(BuildContext context) async {
    if (_foto != null) {
      ImagenResponse respuesta = await _userServices.subirFotoPerfil(_foto);
      respuesta.err
          ? helper.mostrarMensanjeError(context, "Foto de perfil no actualizada")
          : helper.mensanjeOkRedireccionar(context, "Foto de perfil acualizada", "home");
    }
  }
}
