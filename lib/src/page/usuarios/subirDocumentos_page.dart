import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/image/documentos_model.dart';
import 'package:peliculas/src/models/image/responseImagen_model.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;
import 'package:rflutter_alert/rflutter_alert.dart';

class SubirDocumentos extends StatefulWidget {
  @override
  _SubirDocumentosState createState() => _SubirDocumentosState();
}

class _SubirDocumentosState extends State<SubirDocumentos> {
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final UserServices _userServices = new UserServices();

  File _foto;
  bool guardando = false;
  List<DocumentosModel> listDocuments = [];
  Future<List<DocumentosModel>> futureListDocuments;

  @override
  void initState() {
    super.initState();
    futureListDocuments = _getDocumentos();
  }

  Future<List<DocumentosModel>> _getDocumentos() async {
    return await UserServices().getGaleriaDocumentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Seleccione Dui-Nit'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.photo_size_select_actual), onPressed: _seleccionarFoto),
          new IconButton(icon: new Icon(Icons.camera), onPressed: _tomarFoto),
        ],
      ),
      body: FutureBuilder(
          future: futureListDocuments,
          builder: (BuildContext context, AsyncSnapshot<List<DocumentosModel>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.data == null) return helper.noData();
                listDocuments = snapshot.data;
                return cuerpo(context);
              case ConnectionState.active:
                return helper.waitingData();
              case ConnectionState.waiting:
                return helper.waitingData();
              default:
                return helper.noData();
            }
          }),
    );
  }

  SingleChildScrollView cuerpo(BuildContext context) {
    return new SingleChildScrollView(
        child: new Container(
      padding: EdgeInsets.all(15.0),
      child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[_mostrarFoto(), crearBotton(context), _mostrarGaleria()],
          )),
    ));
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
    return Center(
      //pregunta si existe la imagen
      child: Image(image: AssetImage('assets/img/document2.png'), height: 300.0, fit: BoxFit.cover),
    );
  }

  Widget _fotoDocumentoWidget(DocumentosModel doc) {
    ///esto es para evitar problema si no existe el id del producto, como cuando no se a creado
    return Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Container(
                child: FadeInImage(
              placeholder: AssetImage("assets/gif/loading.gif"),
              image: NetworkImage(helper.transformarFoto(doc.fotoPath)),
              imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                return Center(
                  //pregunta si existe la imagen
                  child: Image(image: AssetImage('assets/img/no-image.png'), height: 300.0, fit: BoxFit.cover),
                );
              },
            )),
          ),
        ),
        new RawMaterialButton(
          onPressed: () => alertaEliminar(doc),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          fillColor: Colors.redAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        new Divider(
          color: Colors.grey,
          height: 13,
        )
      ],
    );
  }

  crearBotton(BuildContext context) {
    return guardando
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: CircularProgressIndicator(),
          )
        : RaisedButton.icon(
            onPressed: () => submit(context),
            icon: new Icon(Icons.save),
            label: Text("guardar"),
            shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            color: Colors.blue,
            textColor: Colors.white,
          );
  }

  void submit(BuildContext context) async {
    if (_foto != null) {
      guardando = true;
      setState(() {});
      ImagenResponse respuesta = await _userServices.subirDocumentos(_foto);
      if (respuesta.err) {
        helper.mostrarMensanjeError(context, "Favor intente más tarde");
      } else {
        helper.mostrarMensajeOk(context, "Foto Subida Exitosamente");
        listDocuments.add(
          new DocumentosModel(
            idFoto: respuesta.idFoto.toString(),
            fotoPath: respuesta.path,
          ),
        );
        guardando = false;
        _foto = null;
        setState(() {});
        print(guardando);
      }
    }
  }

  _mostrarGaleria() {
    List<Widget> galeria = [];
    listDocuments.forEach((element) {
      galeria.add(_fotoDocumentoWidget(element));
    });
    return Column(children: galeria);
  }

  alertaEliminar(DocumentosModel doc) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "¿Deséa eliminar imagen?",
      desc: "Eliminará la imagen de manera definitiva",
      buttons: [
        DialogButton(
          child: Text(
            "CANCELAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "ELIMINAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            eliminarFoto(doc);
            Navigator.pop(context);
          },
          color: Colors.redAccent,
        )
      ],
    ).show();
  }

  eliminarFoto(DocumentosModel doc) async {
    bool hecho = await _userServices.eliminarFoto(doc.idFoto);
    if (hecho) {
      print("foto eliminada");
      listDocuments.removeWhere((element) => element.idFoto == doc.idFoto);
      setState(() {});
    }
  }
}
