import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/tipoVehiculo_model.dart';
import 'package:peliculas/src/models/vuelos/CotizarVuelo_model.dart';
import 'package:peliculas/src/models/vuelos/VueloSave_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
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
  TextEditingController _controllerDireccionPartida = new TextEditingController();
  TextEditingController _controllerFechaPartida = new TextEditingController();
  TextEditingController _controllerHoraPartida = new TextEditingController();
  TextEditingController _controllerPunetoLlegada = new TextEditingController();
  TextEditingController _controllerFechaLlegada = new TextEditingController();
  TextEditingController _controllerHoraLlegada = new TextEditingController();
  TextEditingController _controllerOpciones = new TextEditingController();
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  Aerolinea aerolineaSeleccionada;
  Clase claseSeleccionada;
  TiposViaje tipoSeleccionado;
  ModeloVehiculo modeloSeleccionado = ModeloVehiculo();
  List<String> _opcionesAdicionales;

  Color fondo = Colors.green;
  double screenHeight;
  bool isSaving = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureCotizarVuelo = getModelo();
    aerolineaSeleccionada = null;
    claseSeleccionada = null;
    tipoSeleccionado = null;
    _opcionesAdicionales = [];
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

  Widget cajaFormulario(BuildContext context, CotizarVueloModel data) {
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
                    helper.crearTitulo('Punto de Partida'),
                    _inputDireccionPartida(),
                    helper.crearTitulo('Fecha de Partida'),
                    _crearFecha(context, _controllerFechaPartida, 'Seleccione la Fecha'),
                    helper.crearTitulo('Hora de Partida'),
                    _crearHora(context, _controllerHoraPartida, 'Seleccione la Hora'),
                    helper.crearTitulo('Punto de Llegada'),
                    _inputPuntoLlegada(),
                    helper.crearTitulo('Fecha de Llegada'),
                    _crearFecha(context, _controllerFechaLlegada, 'Seleccione la Fecha'),
                    helper.crearTitulo('Hora de Llegada'),
                    _crearHora(context, _controllerHoraLlegada, 'Seleccione la Hora'),
                    helper.crearTitulo('Bebés (0 a 4 años)'),
                    _inputBebes(),
                    helper.crearTitulo('Niños (5 a 11 años)'),
                    _inputNinos(),
                    helper.crearTitulo('Adultos (+12 años)'),
                    _inputAdultos(),
                    helper.crearTitulo('Maletas'),
                    _inputMaletas(),
                    helper.crearTitulo("Seleccione la Aerolinea"),
                    _crearDropdownAerolineas(data.aerolineas),
                    helper.crearTitulo("Seleccione la Clase"),
                    _crearDropdownClases(data.clases),
                    helper.crearTitulo("Seleccione el Tipo de Viaje"),
                    _crearDropdownTipo(data.tiposViajes),
                    helper.crearTitulo("Agregar Opciones Adicionales"),
                    _inputOpciones(),
                    crearSubTitulo("(Mueva a los lados para eliminar)"),
                    SizedBox(height: 4.0),
                    _botonOpcion(),
                    _crearListaOpciones(),
                    SizedBox(height: 4.0),
                    (isSaving) ? CircularProgressIndicator() : _botonEnviar(context)
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

  Widget _inputOpciones() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 18,
        controller: _controllerOpciones,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          alignLabelWithHint: true,
          hintText: 'Opciones Adicionales',
        ),
        onSaved: (String valor) {
          _controllerOpciones.text = valor;
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

  Widget _inputDireccionPartida() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 8,
        controller: _controllerDireccionPartida,
        textAlign: TextAlign.center,
        //envia un paramettro inplicito
        validator: (s) => helper.maxLengthRequired(s, 10),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Digite el punto de partida'),
        onSaved: (String valor) {
          _controllerDireccionPartida.text = valor;
        },
      ),
    );
  }

  Widget _inputPuntoLlegada() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 8,
        controller: _controllerPunetoLlegada,
        textAlign: TextAlign.center,
        //envia un paramettro inplicito
        validator: (s) => helper.maxLengthRequired(s, 10),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Digite el punto de llegada'),
        onSaved: (String valor) {
          _controllerPunetoLlegada.text = valor;
        },
      ),
    );
  }

  Widget _crearDropdownAerolineas(List<Aerolinea> aerolineas) {
    if (aerolineaSeleccionada == null) {
      aerolineaSeleccionada = aerolineas[0];
    }
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
              hintText: "", border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
          icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
          value: aerolineas[0],
          items: aerolineas.map<DropdownMenuItem<Aerolinea>>((Aerolinea aero) {
            return DropdownMenuItem(
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
                value: aero);
          }).toList(),
          onChanged: (Aerolinea opt) {
            setState(() {
              aerolineaSeleccionada = opt;
            });
          }),
    );
  }

  Widget _crearDropdownClases(List<Clase> clases) {
    if (claseSeleccionada == null) {
      claseSeleccionada = clases[0];
    }
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
              hintText: "", border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
          icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
          value: clases[0],
          items: clases.map<DropdownMenuItem<Clase>>((Clase clase) {
            return DropdownMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${clase.nombreClase}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                value: clase);
          }).toList(),
          onChanged: (Clase opt) {
            setState(() {
              claseSeleccionada = opt;
            });
          }),
    );
  }

  Widget _crearDropdownTipo(List<TiposViaje> tipos) {
    if (tipoSeleccionado == null) {
      tipoSeleccionado = tipos[0];
    }
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
              hintText: "", border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
          icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
          value: tipos[0],
          items: tipos.map<DropdownMenuItem<TiposViaje>>((TiposViaje tip) {
            return DropdownMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${tip.nombreTipoviaje}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                value: tip);
          }).toList(),
          onChanged: (TiposViaje opt) {
            setState(() {
              tipoSeleccionado = opt;
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
      label: Text("Enviar Solicitud de cotización"),
      color: Colors.blue,
      textColor: Colors.white,
      focusColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          setState(() {
            isSaving = true;
            guardar(context);
          });
        } else {
          helper.mostrarMensanjeError(context, 'Complete los campos');
        }
      },
    );
  }

  Future<void> guardar(BuildContext context) async {
    var cotizacion = new VueloSaveModel(
      adultos: _controllerAdulto.text,
      bebes: _controllerBebe.text,
      maletas: _controllerMaleta.text,
      ninos: _controllerNino.text,
      ciudadLlegada: _controllerPunetoLlegada.text,
      horaLlegada: _controllerHoraLlegada.text,
      fechaLlegada: _controllerFechaLlegada.text,
      ciudadPartida: _controllerDireccionPartida.text,
      fechaPartida: _controllerFechaPartida.text,
      horaPartida: _controllerFechaPartida.text,
      idtipoViaje: tipoSeleccionado.idtipoViaje,
      idclase: claseSeleccionada.idclase,
      idaerolinea: aerolineaSeleccionada.idaerolinea,
      idCliente: _pref.idCliente,
      opcAvanzadas: optenerOpciones(),
      detallePasajero: "",
    );

    bool res = await VuelosServices().guardarCotizacion(cotizacion);

    if (res) {
      helper.mostrarMensajeOk(context,
          'Solicitud de cotización enviada correctamente, le notificaremos la respuesta en la brevedad posible');
      setState(() {
        isSaving = false;
        _controllerAdulto.clear();
        _controllerBebe.clear();
        _controllerMaleta.clear();
        _controllerNino.clear();
        _controllerPunetoLlegada.clear();
        _controllerHoraLlegada.clear();
        _controllerFechaLlegada.clear();
        _controllerDireccionPartida.clear();
        _controllerFechaPartida.clear();
        _controllerFechaPartida.clear();
      });
    } else {
      helper.mostrarMensanjeError(context, 'Favor intente más tarde');
    }
  }

  Widget _botonOpcion() {
    return RaisedButton.icon(
      icon: Icon(Icons.add),
      label: Text("Agregar"),
      color: Colors.blue,
      textColor: Colors.white,
      focusColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onPressed: () {
        if (_controllerOpciones.text != "") {
          setState(() {
            agregarOpcion();
          });
        }
      },
    );
  }

  Widget _crearListaOpciones() {
    List<Widget> listaIttem = [];
    _opcionesAdicionales.forEach((opcion) {
      listaIttem.add(_crearItemOpcion(opcion));
      listaIttem.add(Divider(color: Colors.white, height: 1));
    });

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: listaIttem,
      ),
    );
  }

  Widget _crearItemOpcion(String opcion) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          eliminarElemento(opcion);
        });
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
      ),
      child: ListTile(
        title: Text(
          opcion,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }

  void eliminarElemento(String opcion) {
    _opcionesAdicionales.removeWhere((element) => element == opcion);
  }

  void agregarOpcion() {
    _opcionesAdicionales.removeWhere((element) => element == _controllerOpciones.text);
    _opcionesAdicionales.add(_controllerOpciones.text);
    _controllerOpciones.clear();
  }

  String optenerOpciones() {
    String strOpcion = " ";
    _opcionesAdicionales.forEach((opt) {
      strOpcion += '$opt, ';
      print(opt);
    });

    if (strOpcion == " ") {
      return "NINGUNA";
    } else {
      return strOpcion;
    }
  }
}
