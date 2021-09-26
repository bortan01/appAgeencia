import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/cotizacionCliente_model.dart';
import 'package:peliculas/src/models/vehiculo/tipoVehiculo_model.dart';
import 'package:peliculas/src/models/vuelos/CotizarVuelo_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/vehiculo_services.dart';
import 'package:intl/intl.dart';
import 'package:peliculas/src/services/vuelos_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class CotizaVuelo extends StatefulWidget {
  const CotizaVuelo({Key key}) : super(key: key);

  @override
  _CotizaVueloState createState() => _CotizaVueloState();
}

class _CotizaVueloState extends State<CotizaVuelo> {
  Future<CotizarVueloModel> futureCotizarVuelo;
  
  TextEditingController _controllerAdulto = new TextEditingController();
  TextEditingController _controllerNino = new TextEditingController();
  TextEditingController _controllerBebe = new TextEditingController();
  TextEditingController _controllerMaleta = new TextEditingController();
  TextEditingController _controllerDireccionRecogida = new TextEditingController();
  TextEditingController _controllerFechaRecogida = new TextEditingController();
  TextEditingController _controllerTimeRecogida = new TextEditingController();
  TextEditingController _controllerDireccionDevolucion = new TextEditingController();
  TextEditingController _controllerFechaDevolucion = new TextEditingController();
  TextEditingController _controllerTimeDevolucion = new TextEditingController();
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  int anioSeleccionado = 0;
  ModeloVehiculo modeloSeleccionado = ModeloVehiculo();

  Color fondo = Colors.green;
  double screenHeight;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureCotizarVuelo = getModelo();
   }

  Future<CotizarVueloModel> getModelo() async {
    final respuesta = await VuelosServices().obtenerDataCotizacion();
    return respuesta;
  }

  List<int> getListYear() {
    List<int> lista = [];
    int year = DateTime.now().year + 1;
    for (var i = 10; i > 0; i--) {
      lista.add(year - i);
    }
    anioSeleccionado = lista[0];
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarCarrito(),
      body: FutureBuilder(
          future: futureCotizarVuelo,
          builder: (BuildContext context, AsyncSnapshot<CotizarVueloModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.data == null) return helper.noData();
                return cuerpo(context, snapshot.data);
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

  SingleChildScrollView cuerpo(BuildContext context, CotizarVueloModel data) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          paginaFondo(),
          imagenPortada(context),
          cajaFormulario(context, data),
        ],
      ),
    );
  }

  Widget appBarCarrito() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Cotizar Vuelo"),
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

  Widget cajaFormulario(BuildContext context,CotizarVueloModel data ) {
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
                    helper.crearTitulo("Seleccione el modelo"),
                    _crearDropdownYears(data.aerolineas),
                    helper.crearTitulo('Punto de Partida'),
                    _inputDireccionRecogida(),
                    helper.crearTitulo('Fecha de Partida'),
                    _crearFecha(context, _controllerFechaRecogida, 'Seleccione la Fecha'),
                    helper.crearTitulo('Hora de Partida'),
                    _crearHora(context, _controllerTimeRecogida, 'Seleccione la Hora'),
                    helper.crearTitulo('Punto de Llegada'),
                    _inputDireccionDevolucion(),
                    helper.crearTitulo('Fecha de Llegada'),
                    _crearFecha(context, _controllerFechaDevolucion, 'Seleccione la Fecha'),
                    helper.crearTitulo('Hora de Llegada'),
                    _crearHora(context, _controllerTimeDevolucion, 'Seleccione la Hora'),
                    helper.crearTitulo('Bebés (0 a 4 años)'),
                    _inputBebes(),
                    helper.crearTitulo('Niños (5 a 11 años)'),
                    _inputNinos(),
                    helper.crearTitulo('Adultos (+12 años)'),
                    _inputAdultos(),
                    helper.crearTitulo('Maletas'),
                    _inputMaletas(),
                    _botonAgregar(context)
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

  Widget _inputAdultos() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        minLines: 1,
        maxLines: 18,
        controller: _controllerAdulto,
        textAlign: TextAlign.center,
        validator: (s) => helper.isNumericRequired(s),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          alignLabelWithHint: true,
          hintText: 'Número de Adultos',
        ),
        onSaved: (String valor) {
          _controllerAdulto.text = valor;
        },
      ),
    );
  }

  Widget _inputNinos() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        minLines: 1,
        maxLines: 18,
        controller: _controllerNino,
        textAlign: TextAlign.center,
        validator: (s) => helper.isNumericRequired(s),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          alignLabelWithHint: true,
          hintText: 'Número de Niños',
        ),
        onSaved: (String valor) {
          _controllerNino.text = valor;
        },
      ),
    );
  }

  Widget _inputBebes() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        minLines: 1,
        maxLines: 18,
        controller: _controllerBebe,
        textAlign: TextAlign.center,
        validator: (s) => helper.isNumericRequired(s),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          alignLabelWithHint: true,
          hintText: 'Número de Niños',
        ),
        onSaved: (String valor) {
          _controllerBebe.text = valor;
        },
      ),
    );
  }

  Widget _inputMaletas() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        minLines: 1,
        maxLines: 18,
        controller: _controllerMaleta,
        textAlign: TextAlign.center,
        validator: (s) => helper.isNumericRequired(s),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          alignLabelWithHint: true,
          hintText: 'Número de Maletas',
        ),
        onSaved: (String valor) {
          _controllerMaleta.text = valor;
        },
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

  Widget _crearHora(BuildContext context, TextEditingController controller, String hint) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        enableInteractiveSelection: false,
        validator: (s) => helper.minLengthRequired(s, 2),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: hint,
            alignLabelWithHint: true),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectTime(context, controller);
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
        controller.text = DateFormat('yyyy-MM-dd').format(fecha);
      });
    }
  }

  _selectTime(BuildContext context, TextEditingController controller) async {
    TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          if (MediaQuery.of(context).alwaysUse24HourFormat) {
            return child;
          } else {
            return Localizations.override(
              context: context,
              locale: Locale('es', 'US'),
              child: child,
            );
          }
        });
    if (picked != null) {
      setState(() {
        controller.text = '${picked.hour}:${picked.minute}:00';
      });
    }
  }

  Widget _inputDireccionRecogida() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 8,
        controller: _controllerDireccionRecogida,
        textAlign: TextAlign.center,
        //envia un paramettro inplicito
        validator: (s) => helper.maxLengthRequired(s, 10),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Digite la direccion de recogida'),
        onSaved: (String valor) {
          _controllerDireccionRecogida.text = valor;
        },
      ),
    );
  }

  Widget _inputDireccionDevolucion() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 8,
        controller: _controllerDireccionDevolucion,
        textAlign: TextAlign.center,
        //envia un paramettro inplicito
        validator: (s) => helper.maxLengthRequired(s, 10),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Digite la direccion de devolución'),
        onSaved: (String valor) {
          _controllerDireccionDevolucion.text = valor;
        },
      ),
    );
  }

  // Widget _crearDropdown() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
  //     child: DropdownButtonFormField(
  //         isExpanded: true,
  //         decoration: InputDecoration(
  //             hintText: "", border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
  //         icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
  //         value: listaModelos[0],
  //         items: opcionesDropdown(),
  //         onChanged: (ModeloVehiculo opt) {
  //           setState(() {
  //             modeloSeleccionado = opt;
  //           });
  //         }),
  //   );
  // }

  Widget _crearDropdownYears(List<Aerolinea> aerolineas) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
              hintText: "", border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
          icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
          value: aerolineas[0],
          items: opcionesDropdownYears(aerolineas),
          onChanged: (Aerolinea opt) {
            setState(() {
              // anioSeleccionado = opt;
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

  // List<DropdownMenuItem<ModeloVehiculo>> opcionesDropdown() {
  //   List<DropdownMenuItem<ModeloVehiculo>> lista = new List();
  //   listaModelos.forEach((mod) {
  //     lista.add(DropdownMenuItem(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Expanded(
  //               child: Container(
  //                 padding: const EdgeInsets.only(right: 8.0),
  //                 child: Text(
  //                   '${mod.modelo}',
  //                   maxLines: 4,
  //                   overflow: TextOverflow.ellipsis,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         value: mod));
  //   });

  //   return lista;
  // }

  List<DropdownMenuItem<Aerolinea>> opcionesDropdownYears(List<Aerolinea> aerolineeas) {
    List<DropdownMenuItem<Aerolinea>> lista = new List();
    aerolineeas.forEach((aero) {
      lista.add(DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${aero.nombreAerolinea}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          value: aero));
    });

    return lista;
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
          // guardar(context);
        } else {
          helper.mostrarMensanjeError(context, 'Complete los campos');
        }
      },
    );
  }

  Future<void> guardar(BuildContext context) async {
    var miModel = CotizacionClienteModel(
      anio: anioSeleccionado.toString(),
      modelo: modeloSeleccionado.idmodelo,
      caracteristicas: _controllerAdulto.text,
      direccionDevolucion: _controllerDireccionDevolucion.text,
      direccionRecogida: _controllerDireccionRecogida.text,
      fechaDevolucion: _controllerFechaDevolucion.text,
      fechaRecogida: _controllerFechaRecogida.text,
      horaDevolucion: _controllerTimeDevolucion.text,
      horaRecogida: _controllerTimeRecogida.text,
      idUsuario: _pref.idCliente,
    );
    bool res = await VehiculoServices().guardarReserva(miModel);
    print("done");
    if (res) {
      helper.mostrarMensajeOk(context,
          'Solicitud de cotización enviada correctamente, le notificaremos la respuesta en la brevedad posible');
      setState(() {
        _controllerAdulto.clear();
        _controllerDireccionDevolucion.clear();
        _controllerDireccionRecogida.clear();
        _controllerFechaDevolucion.clear();
        _controllerFechaRecogida.clear();
        _controllerTimeDevolucion.clear();
        _controllerTimeRecogida.clear();
      });
    } else {
      helper.mostrarMensanjeError(context, 'Favor intente más tarde');
    }
  }
}
