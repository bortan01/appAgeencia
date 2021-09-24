import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vuelos/vuelos_model.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/widget/chip_widget.dart';
import 'package:peliculas/src/widget/descripcion_widget.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetalleVuelo extends StatefulWidget {
  final Promocione dataPromocion;

  const DetalleVuelo({@required this.dataPromocion});

  @override
  _DetalleVueloState createState() => _DetalleVueloState();
}

class _DetalleVueloState extends State<DetalleVuelo> {
  int pasoActual = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: scrollView(context, widget.dataPromocion));
  }

  Widget scrollView(BuildContext context, Promocione dataPromocion) {
    return CustomScrollView(
      slivers: <Widget>[
        AppBarWidget(
          titulo: dataPromocion.nombrePromocion,
          imagen: transformarFoto(dataPromocion.foto),
          id: dataPromocion.idpromocionVuelo,
        ),
        new SliverList(
          delegate: new SliverChildListDelegate(
            [
              new SizedBox(height: 10.0),
              helper.posterTitulo(context: context, title: dataPromocion.nombrePromocion),
              new SizedBox(height: 10.0),
              new Divider(color: Colors.grey, height: 20.0),
              helper.crearTitulo("Descripción"),
              descripcion(dataPromocion.descripcion),
              helper.crearTitulo("Precio por Persona"),
              info(tipo: TypeChip.azul, txt: '\$${dataPromocion.precioPromocion}'),
              helper.crearTitulo("Saliendo de"),
              info(tipo: TypeChip.anaranjado, txt: dataPromocion.lugarSalidaPromocion),
              helper.crearTitulo("País"),
              info(tipo: TypeChip.purpura, txt: dataPromocion.paisPromocion),
              helper.crearTitulo("Aerolinea"),
              info(tipo: TypeChip.verde, txt: dataPromocion.nombreAerolinea),
              helper.crearTitulo("Tipo de Clase"),
              info(tipo: TypeChip.rojo, txt: dataPromocion.nombreClase),
              _crearBoton(context),
              descripcion(
                  "*Restricciones aplican, en caso de querer adquirir la promoción, favor ponerse en contacto con la Agencia"),
              SizedBox(height: 30.0)
            ],
          ),
        )
      ],
    );
  }

  Widget _crearBoton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: new RaisedButton.icon(
        label: new Text("Vistítanos Para Reservar"),
        icon: new Icon(Icons.home),
        color: Theme.of(context).accentColor,
        textColor: Theme.of(context).bottomAppBarColor,
        shape: StadiumBorder(),
        onPressed: () => {},
      ),
    );
  }

  Widget info({@required TypeChip tipo, @required String txt}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: ChipWidget(text: txt, type: tipo),
    );
  }
}
