import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class SubirImagenes extends StatefulWidget {
  @override
  _SubirImagenesState createState() => _SubirImagenesState();
}

class _SubirImagenesState extends State<SubirImagenes> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();
  bool _guardando = false;
  PickedFile foto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Seleccione Foto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[_mostrarFoto()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mostrarFoto() {
    if (false) {
      return FadeInImage(
        image: NetworkImage(''),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    // _procesarImagen( ImageSource.camera );
  }

  // _procesarImagen( ImageSource origen ) async {

  //   foto = await ImagePicker.imagePicker.getImage(
  //     source: origen
  //   );

  //   if ( foto != null ) {
  //     producto.fotoUrl = null;
  //   }

  //   setState(() {});

  // }
  _procesarImagen(ImageSource origen) async {
    foto = await _picker.getImage(
      source: origen,
      // maxWidth: 20000,
      // maxHeight: maxHeight,
      // imageQuality: quality,
    );
    if (foto != null) {
      // producto.fotoUrl = null;
    }

    setState(() {});
  }
}
