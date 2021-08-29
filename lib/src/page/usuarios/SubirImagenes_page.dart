import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/image/documentos_model.dart';
import 'package:peliculas/src/models/image/responseImagen_model.dart';
// import 'package:peliculas/src/models/image/imagen_model.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;
import 'package:rflutter_alert/rflutter_alert.dart';

class SubirImagenes extends StatefulWidget {
  @override
  _SubirImagenesState createState() => _SubirImagenesState();
}

class _SubirImagenesState extends State<SubirImagenes> {
  final picker = ImagePicker();
  File _foto;
  Future<DocumentosModel> photoProfile;
  bool guardando = false;
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

  Widget _mostrarFoto(DocumentosModel photo) {
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
    if (photo.fotoPath != '') {
      return Container(

          ///esto es para evitar problema si no existe el id del producto, como cuando no se a creado
          child: new Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
              child: FadeInImage(
            placeholder: AssetImage("assets/gif/loading.gif"),
            image: NetworkImage(helper.transformarFoto(photo.fotoPath)),
          )),
        ),
      ));
    }
  }

  crearBotton(BuildContext context) {
    if (guardando == true) {
      return Container(margin: EdgeInsets.only(top: 15.0), child: CircularProgressIndicator());
    } else {
      return Container(
        margin: EdgeInsets.only(top: 15.0),
        child: RaisedButton.icon(
          onPressed: () => submit(context),
          icon: new Icon(Icons.save),
          label: Text("guardar"),
          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: Colors.blue,
          textColor: Colors.white,
        ),
      );
    }
  }

  submit(BuildContext context) async {
    setState(() {
      guardando = true;
    });

    if (_foto != null) {
      ImagenResponse respuesta = await _userServices.subirFotoPerfil(_foto);
      if (respuesta.err) {
        helper.mostrarMensanjeError(context, "Foto de perfil no actualizada");
      } else {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Listo",
          desc: "Foto actualizada",
          buttons: [
            DialogButton(
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            )
          ],
        ).show();
      }
    }
  }
}
