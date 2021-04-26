import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/tipoVehiculo_model.dart';
import 'package:peliculas/src/services/vehiculo_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class CotizaVehiculo extends StatefulWidget {
  const CotizaVehiculo({Key key}) : super(key: key);

  @override
  _CotizaVehiculoState createState() => _CotizaVehiculoState();
}

class _CotizaVehiculoState extends State<CotizaVehiculo> {
  Future<List<ModeloVehiculo>> futureModelos;
  Color fondo = Colors.green;
  double screenHeight;
  // // List<ModeloVehiculo> opcionesSeleccionadas = [];
  List<ModeloVehiculo> listaModelos = [];
  // // int cantidadSeleccionada = 1;
  // int numeroDias = 1;
  // double total = 0.0;
  // ModeloVehiculo opcionSelecionada;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureModelos = getModelo();
  }

  Future<List<ModeloVehiculo>> getModelo() async {
    final respuesta = await VehiculoServices().obtenerModelo();
    listaModelos = respuesta;
    return respuesta;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarCarrito(),
      body: FutureBuilder(
          future: futureModelos,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.data == null) return helper.noData();
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
      title: Text("Cotizar Vehículo"),
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
                    helper.crearTitulo("Seleccione el modelo"),
                    _crearDropdown(),
                    helper.crearTitulo(''),
                    _inputCantidadDias(),
                    _inputCantidad(),
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

  Widget _inputCantidad() {
    return TextFormField(
      initialValue: "1",
      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
      textAlign: TextAlign.center,
      //envia un paramettro inplicito
      validator: helper.isNumeric,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)), labelText: 'ingrese cantidad'),
      onSaved: (String valor) {
        // cantidadSeleccionada = int.parse(valor);
      },
    );
  }

  Widget _inputCantidadDias() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 10.0, bottom: 8.0),
      child: TextFormField(
        initialValue: "1",
        keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
        textAlign: TextAlign.center,
        validator: helper.isNumeric,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)), labelText: 'ingrese numero de Dias'),
        onSaved: (String valor) {
          // numeroDias = int.parse(valor);
        },
        onChanged: (String valor) {
          setState(() {});
        },
      ),
    );
  }

  Widget _crearDropdown() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
              hintText: "", border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
          icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
          value: listaModelos[0],
          items: opcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              // opcionSelecionada = opt;
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

  List<DropdownMenuItem<ModeloVehiculo>> opcionesDropdown() {
    List<DropdownMenuItem<ModeloVehiculo>> lista = new List();
    listaModelos.forEach((mod) {
      lista.add(DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${mod.modelo}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          value: mod));
    });

    return lista;
  }
}
