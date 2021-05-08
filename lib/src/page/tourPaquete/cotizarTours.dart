import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/cotizar_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class CotizarTours extends StatefulWidget {
  @override
  _CotizarToursState createState() => _CotizarToursState();
}

class _CotizarToursState extends State<CotizarTours> {
  int filas;

  double screenHeight;

  TextEditingController _controllerFecha = new TextEditingController();
  TextEditingController _controllerDescripcion = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBarAlquiler(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            paginaFondo(),
            imagenPortada(context),
            cajaFormulario(context),
          ],
        ),
      ),
    );
  }

  Widget appBarAlquiler() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Cotizar Viaje"),
    );
  }

  Widget paginaFondo() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "",
            style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget cajaFormulario(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    helper.crearTitulo("¿Cuándo desea realizar su viaje?"),
                    _crearFecha(context, _controllerFecha, 'Seleccione la Fecha'),
                    helper.crearTitulo("Describa su viaje ideal"),
                    _inputDescripcion(),
                    _botonAgregar(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget imagenPortada(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/img/portada.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _crearFecha(BuildContext context, TextEditingController controller, String hint) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new TextFormField(
        controller: controller,
        enableInteractiveSelection: false,
        textAlign: TextAlign.center,
        validator: (s) => helper.minLengthRequired(s, 2),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: hint,
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context, controller);
        },
      ),
    );
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    );
    if (picked != null) {
      setState(() {
        var fecha = picked;
        controller.text = helper.transformarFecha(fecha);
      });
    }
  }

  Widget _botonAgregar(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.send),
      label: Text("Enviar Solicitud de cotización"),
      color: Colors.blue,
      textColor: Colors.white,
      focusColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          guardar(context);
        }
      },
    );
  }

  Widget _inputDescripcion() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        minLines: 6,
        maxLines: 18,
        controller: _controllerDescripcion,
        textAlign: TextAlign.center,
        validator: (s) => helper.maxLengthRequired(s, 10),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          alignLabelWithHint: true,
          hintText: 'Digite las características que desee',
        ),
        onSaved: (String valor) {
          _controllerDescripcion.text = valor;
        },
      ),
    );
  }

  Future<void> guardar(BuildContext context) async {
    PreferenciasUsuario pref = PreferenciasUsuario();
    CotizarModel cotizacion = CotizarModel(
      idCliente: pref.idCliente,
      fechaPeticion: _controllerFecha.text,
      peticion: _controllerDescripcion.text,
      visto: "0",
    );

    bool res = await TurServices().guardaCotizacion(cotizacion);
    if (res) {
      helper.mostrarMensajeOk(context,
          'Solicitud de cotización enviada correctamente, le notificaremos la respuesta en la brevedad posible');
      _controllerDescripcion.clear();
      _controllerFecha.clear();
      setState(() {});
    } else {
      helper.mostrarMensanjeError(context, 'Favor intente más tarde');
    }
  }
}
