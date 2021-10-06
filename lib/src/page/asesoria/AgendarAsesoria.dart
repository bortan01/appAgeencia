import 'package:flutter/material.dart';
import 'package:peliculas/src/models/asesoria/AsesoriaSave_model.dart';
import 'package:peliculas/src/models/vehiculo/tipoVehiculo_model.dart';
import 'package:peliculas/src/models/vuelos/VueloSave_model.dart';
import 'package:intl/intl.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/vuelos_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class AgendarAsesoria extends StatefulWidget {
  const AgendarAsesoria({Key key}) : super(key: key);

  @override
  _AgendarAsesoriaState createState() => _AgendarAsesoriaState();
}

class _AgendarAsesoriaState extends State<AgendarAsesoria> {
  TextEditingController _controllerFechaLlegada = new TextEditingController();

  // PreferenciasUsuario _pref = new PreferenciasUsuario();
  String horaSeleccionada;

  ModeloVehiculo modeloSeleccionado = ModeloVehiculo();
  DateTime fechaSeleccionada;
  DateTime hoy;
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  Color fondo = Colors.green;
  double screenHeight;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    horaSeleccionada = "08:00";
    fechaSeleccionada = DateTime.now();
    hoy = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarCarrito(),
      body: cuerpo(context),
    );
  }

  SingleChildScrollView cuerpo(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          paginaFondo(),
          imagenPortada(context),
          cajaFormulario(context),
        ],
      ),
    );
  }

  Widget appBarCarrito() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Agendar Cita"),
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
          margin: EdgeInsets.only(top: screenHeight / 4, bottom: 30.0),
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
                    helper.crearTitulo("Seleccione la Fecha"),
                    _crearFecha(context, _controllerFechaLlegada, 'Seleccione la Fecha'),
                    helper.crearTitulo("Seleccione la Hora"),
                    _crearDropdownHora(),
                    _botonEnviar(context)
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
        fechaSeleccionada = picked;
        controller.text = DateFormat('d/M/y').format(fechaSeleccionada);
      });
    }
  }

  Widget _crearDropdownHora() {
    List<String> horas = ["08:00", "09:00", "10:00", "11:00", "13:00", "14:00"];

    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
              hintText: "", border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
          icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
          value: horas[0],
          items: horas.map<DropdownMenuItem<String>>((String hora) {
            return DropdownMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          hora,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                value: hora);
          }).toList(),
          onChanged: (String opt) {
            setState(() {
              horaSeleccionada = opt;
            });
          }),
    );
  }

  Text crearSubTitulo(String tiulo) {
    return Text(
      tiulo,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
    );
  }

  Widget _botonEnviar(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.send),
      label: Text("Agendar Cita"),
      color: Colors.blue,
      textColor: Colors.white,
      focusColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () => _validacionAdicional(),
    );
  }

  void _validacionAdicional() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (!fechaSeleccionada.isBefore(hoy) || isSameDate(fechaSeleccionada, hoy)) {
        bool isSunday = DateFormat('EEEE').format(fechaSeleccionada) == 'Sunday';
        if (!isSunday) {
          String fecha = DateFormat('d-M-y').format(fechaSeleccionada);
          AsesoriaSaveModel model = AsesoriaSaveModel(
            cobros: "0",
            title: "Asesoria",
            idCliente: _pref.idCliente,
            usuario: _pref.nombre,
            start: horaSeleccionada,
            fecha: fecha,
          );
            } else {
          helper.mostrarMensanjeError(context, 'Este dia esta cerrado!');
        }
      } else {
        helper.mostrarMensanjeError(context, 'No se puede agendar una cita en el pasado');
      }
    } else {
      helper.mostrarMensanjeError(context, 'Complete los campos');
    }
  }

  Future<void> guardar(BuildContext context) async {
    bool res = await VuelosServices().guardarCotizacion(new VueloSaveModel());

    if (res) {
      helper.mostrarMensajeOk(context,
          'Solicitud de cotización enviada correctamente, le notificaremos la respuesta en la brevedad posible');
      setState(() {
        // _controllerAdulto.clear();
      });
    } else {
      helper.mostrarMensanjeError(context, 'Favor intente más tarde');
    }
  }

  bool isSameDate(DateTime fecha1, fecha2) {
    return (fecha1.day == fecha2.day && fecha1.month == fecha2.month && fecha1.year == fecha2.year);
  }
}
