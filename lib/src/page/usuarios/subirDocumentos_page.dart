import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/image/documentos_model.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class SubirDocumentos extends StatefulWidget {
  @override
  _SubirDocumentosState createState() => _SubirDocumentosState();
}

class _SubirDocumentosState extends State<SubirDocumentos> {
  final picker = ImagePicker();
  File _foto;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final UserServices _userServices = new UserServices();
  Future<List<DocumentosModel>> listDocuments;
  @override
  void initState() {
    super.initState();
    listDocuments = _getDocumentos();
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
            future: listDocuments,
            builder: (BuildContext context, AsyncSnapshot<List<DocumentosModel>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data == null) return helper.noData();
                  return cuerpo(context, snapshot.data);
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return helper.noData();
              }
            }));
  }

  SingleChildScrollView cuerpo(BuildContext context, List<DocumentosModel> documents) {
    return new SingleChildScrollView(
        child: new Container(
      padding: EdgeInsets.all(15.0),
      child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[_mostrarFoto(), crearBotton(context), _mostrarGaleria(documents)],
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
        child: Image.file(_foto, height: 300.0, fit: BoxFit.cover),
      );
    }
    return Center(
        //pregunta si existe la imagen
        child: Image(image: AssetImage('assets/img/document2.png'), height: 300.0, fit: BoxFit.cover));
  }

  Widget _fotoDocumentoWidget(String url) {
    ///esto es para evitar problema si no existe el id del producto, como cuando no se a creado
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50.0)),
          child: Container(
            child: new FadeInImage(
              placeholder: new AssetImage('assets/gif/loading.gif'),
              image: NetworkImage(helper.transformarFoto(url)),
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
        new RawMaterialButton(
          onPressed: () => null,
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
    return RaisedButton.icon(
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
      bool respuesta = await _userServices.subirFoto(_foto, 'usuario_documentos');
      respuesta
          ? helper.mostrarMensajeOk(context, "Foto Subida Exitosamente")
          : helper.mostrarMensanjeError(context, "Favor intente más tarde");
    }
  }

  _mostrarGaleria(List<DocumentosModel> documents) {
    List<Widget> galeria = [];
    documents.forEach((element) {
      galeria.add(_fotoDocumentoWidget(element.fotoPath));
    });
    return Column(children: galeria);
  }
}
