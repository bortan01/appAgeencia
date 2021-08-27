import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/image/documentos_model.dart';
import 'package:peliculas/src/models/image/responseImagen_model.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class SubirImagenes extends StatefulWidget {
  @override
  _SubirImagenesState createState() => _SubirImagenesState();
}

class _SubirImagenesState extends State<SubirImagenes> {
  final picker = ImagePicker();
  File _foto;
  Future<DocumentosModel> photoProfile;
  // final _imagenModel = new ImagenModel();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final UserServices _userServices = new UserServices();

  @override
  void initState() {
    super.initState();
    photoProfile = _getProfile();
  }

  Future<DocumentosModel> _getProfile() async {
    return await UserServices().getPhotoProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Seleccione su foto'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.photo_size_select_actual), onPressed: _seleccionarFoto),
          // new IconButton(icon: new Icon(Icons.camera), onPressed: _tomarFoto),
        ],
      ),
      body: FutureBuilder(
        future: photoProfile,
        builder: (BuildContext context, AsyncSnapshot<DocumentosModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return cuerpo(context, snapshot.data);
            case ConnectionState.active:
              return helper.waitingData();
            case ConnectionState.waiting:
              return helper.waitingData();
            default:
              return helper.noData();
          }
        },
      ),
    );
  }

  SingleChildScrollView cuerpo(BuildContext context, DocumentosModel photo) {
    return new SingleChildScrollView(
        child: new Container(
      padding: EdgeInsets.all(15.0),
      child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              photo == null ? mostrarAvatar() : _mostrarFoto(photo),
              crearBotton(context),
            ],
          )),
    ));
  }

  Widget mostrarAvatar() {
    return Center(
        //pregunta si existe la imagen
        child: Image(image: AssetImage('assets/img/avatar.png'), height: 300.0, fit: BoxFit.cover));
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

  Widget _mostrarFoto(DocumentosModel photo) {
    return Column(
      children: <Widget>[
        Center(
          child: new Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                  child: FadeInImage(
                placeholder: AssetImage("assets/gif/loading.gif"),
                image: NetworkImage(helper.transformarFoto(photo.fotoPath)),
                imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  return Center(
                    //pregunta si existe la imagen
                    child: Image(image: AssetImage('assets/img/no-image.png'), height: 300.0, fit: BoxFit.cover),
                  );
                },
              )),
            ),
          ),
        ),
      ],
    );
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
