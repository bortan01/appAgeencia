import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/DataTourPaquete_model.dart';
import 'package:peliculas/src/models/tourPaquete/Wompi_model.dart';
import 'package:peliculas/src/models/tourPaquete/detalleTur_model.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/widget/crear_bus.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class SeleccionarAsiento extends StatefulWidget {
  final DetalleTurModel detalle;
  final Transporte transporte;
  SeleccionarAsiento({
    Key key,
    @required this.detalle,
    this.transporte,
  }) : super(key: key);

  @override
  _SeleccionarAsientoState createState() => _SeleccionarAsientoState();
}

class _SeleccionarAsientoState extends State<SeleccionarAsiento> {
  final fcaffolKey = GlobalKey<ScaffoldState>();
  final turServices = new TurServices();
  double screenHeight;
  List<String> listAsientosSeleccionados = [];
  List<String> labelAsientos = [];
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: fcaffolKey,
      appBar: appBar(),
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

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Carrito de Compras"),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  crearTitulo('Elija ${widget.detalle.cantidadAsientos.toString()} Asiento(s)'),
                  crearSubTitulo("(Asientos color verde)"),
                  SizedBox(height: 4.0),
                  crearBus(
                    context: context,
                    asientosIzquierdos: int.parse(widget.transporte.asientoIzquierdo),
                    asientosDerecho: int.parse(widget.transporte.asientoDerecho),
                    filas: int.parse(widget.transporte.filas),
                    deshabilitados: widget.transporte.asientosDeshabilitados,
                    ocupados: widget.transporte.ocupados,
                    filaTrasera: widget.transporte.filaTrasera,
                    agregarAsiento: agregarAsiento,
                    eliminarAsiento: eliminarAsiento,
                  ),
                  SizedBox(height: 20),
                  _botonPagar(context)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _botonPagar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: (_guardando) ? CircularProgressIndicator() : Text("Continuar"),
          color: Colors.blue,
          textColor: Colors.white,
          padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: (_guardando) ? null : _reservar,
        )
      ],
    );
  }

  void _reservar() async {
    if (listAsientosSeleccionados.length != widget.detalle.cantidadAsientos) {
      helper.mostrarMensanjeError(
          context, 'Debe de seleccionar ${widget.detalle.cantidadAsientos.toString()} asiento(s)');
    } else {
      setState(() {
        print("redibujando");
        _guardando = true;
      });
      String strIdAsientos = '';
      listAsientosSeleccionados.forEach((idAsiento) {
        strIdAsientos += idAsiento + ',';
      });

      String strLabelAsientos = labelAsientos.toString();
      widget.detalle.asientosSeleccionados = strIdAsientos;
      widget.detalle.labelAsiento = strLabelAsientos.substring(1, strLabelAsientos.length - 1);
      print(strIdAsientos);

      final WompiModel resultado = await turServices.guardarReserva(widget.detalle);
      if (resultado != null) {
        String url = resultado.urlEnlace;
        Alert(
          context: context,
          type: AlertType.success,
          title: "Listo",
          desc: 'Será redirigido a nuestra pasarela de pago',
          buttons: [
            DialogButton(
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                helper.redireccionar(context, url);
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            )
          ],
        ).show();
      } else {
      helper.mostrarMensanjeError(context, "Intete más tarde");
      }
    }
  }

  void mostrarSnackbar(String mensaje) {
    final snack = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 2),
    );
    fcaffolKey.currentState.showSnackBar(snack);
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

  Text crearTitulo(String tiulo) {
    return Text(
      tiulo,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }

  Text crearSubTitulo(String tiulo) {
    return Text(
      tiulo,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
    );
  }

  void agregarAsiento(String identificadorAsiento, String label) {
    listAsientosSeleccionados.add(identificadorAsiento);
    labelAsientos.add(label);
  }

  void eliminarAsiento(String identificadorAsiento, String label) {
    listAsientosSeleccionados.remove(identificadorAsiento);
    labelAsientos.remove(label);
  }
}
