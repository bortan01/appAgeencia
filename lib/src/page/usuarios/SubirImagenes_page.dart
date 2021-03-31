import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/image/imagen_model.dart';
import 'package:peliculas/src/services/user_services.dart';

class SubirImagenes extends StatefulWidget {
  @override
  _SubirImagenesState createState() => _SubirImagenesState();
}

class _SubirImagenesState extends State<SubirImagenes> {
  final picker = ImagePicker();
  File _foto;
  final _imagenModel = new ImagenModel();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final UserServices _userServices = new UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Home'),
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
                  crearBotton(),
                ],
              )),
        )));
  }

  void _seleccionarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imagenModel.fotoUrl = null;
    }

    setState(() {
      _foto = File(pickedFile.path);
    });
  }

  void _tomarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _imagenModel.fotoUrl = null;
    }
    setState(() {
      _foto = File(pickedFile.path);
    });
  }

  Widget _mostrarFoto() {
    if (_imagenModel.fotoUrl != null) {
      return Container(
        ///esto es para evitar problema si no existe el id del producto, como cuando no se a creado

        child: new FadeInImage(
          placeholder: new AssetImage('assets/gif/loading.gif'),
          image: NetworkImage(_imagenModel.fotoUrl),
          height: 300.0,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Center(
        //pregunta si existe la imagen
        child: (_foto == null)
            ?
            //si la imagen no existe se carga una imagen por defecto
            Image(image: AssetImage('assets/img/no-image.png'), height: 300.0, fit: BoxFit.cover)
            :
            //de lo contrario se carga la imagen cargda
            Image.file(_foto, height: 300.0, fit: BoxFit.cover),
      );
    }
  }

  crearBotton() {
    return RaisedButton.icon(
      onPressed: submit,
      icon: new Icon(Icons.save),
      label: Text("guardar"),
      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurpleAccent,
      textColor: Colors.white,
    );
  }

  submit() async {
    if (_foto != null) {
      await _userServices.subirFotoPerfil(_foto);
    }
  }
}
