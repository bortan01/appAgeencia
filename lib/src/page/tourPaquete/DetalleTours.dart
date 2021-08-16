import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/DataTourPaquete_model.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/widget/chip_widget.dart';
import 'package:peliculas/src/widget/galeria.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetalleTours extends StatefulWidget {
  final DataTourPaqueteModel dataTourPaquete;
  const DetalleTours({@required this.dataTourPaquete});

  @override
  _DetalleToursState createState() => _DetalleToursState();
}

class _DetalleToursState extends State<DetalleTours> {
  int pasoActual = 0;
  Future infoAdicional;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TurServices>(context, listen: false);
    // final dynamic tur = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: scrollView(context, widget.dataTourPaquete));
  }



  Widget scrollView(BuildContext context, DataTourPaqueteModel dataTourPaquete) {
    return CustomScrollView(
      slivers: <Widget>[
        AppBarWidget(
          titulo: widget.dataTourPaquete.nombreTours,
          imagen: transformarFoto(widget.dataTourPaquete.foto),
          id: widget.dataTourPaquete.idTours.toString(),
        ),
        new SliverList(
            delegate: new SliverChildListDelegate([
          new SizedBox(
            height: 10.0,
          ),
          helper.posterTitulo(context: context, title: widget.dataTourPaquete.nombreTours),
          new SizedBox(height: 10.0),
          new Divider(
            color: Colors.grey,
            height: 20.0,
          ),
          helper.crearTitulo("Descripción"),
          _descripcion(dataTourPaquete.descripcionForApp),
          helper.crearTitulo("Incluye"),
          listaHorizontal(tipo: TypeChip.azul, lista: dataTourPaquete.incluye),
          helper.crearTitulo("Lugares de Salida"),
          listaHorizontal(tipo: TypeChip.verde, lista: dataTourPaquete.lugarSalida),
          helper.crearTitulo("Requisitos"),
          listaHorizontal(tipo: TypeChip.anaranjado, lista: dataTourPaquete.requisitos),
          helper.crearTitulo("No incluye"),
          listaHorizontal(tipo: TypeChip.rojo, lista: dataTourPaquete.noIncluye),
          _crearBoton(context),
        ]))
      ],
    );
  }

  Widget listaHorizontal({@required TypeChip tipo, @required List<String> lista}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11.0),
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: lista.map((item) {
          return Container(padding: EdgeInsets.symmetric(vertical: 3.0), child: ChipWidget(text: item, type: tipo));
        }).toList(),
      ),
    );
  }

  List<Step> listaDeElementos(dynamic informacionAdicional) {
    List<Step> myLista = [];
    informacionAdicional['sitiosTuristicos'].forEach((item) {
      myLista.add(
        new Step(
            title: new Text(item['nombre_sitio']),
            content: Column(
              children: <Widget>[
                new Text(
                  item['descripcion_sitio'],
                  textAlign: TextAlign.justify,
                ),
                Galeria(galeria: item['galeria']),
              ],
            ),
            state: StepState.complete,
            isActive: true),
      );
    });

    informacionAdicional['serviciosAdicionales'].forEach((item) {
      myLista.add(
        new Step(
            title: new Text(item['nombre_servicio']),
            content: Column(
              children: <Widget>[
                new Text(
                  item['descripcion_servicio'],
                  textAlign: TextAlign.justify,
                ),
                Galeria(
                  galeria: item['galeria'],
                ),
              ],
            ),
            state: StepState.complete,
            isActive: true),
      );
    });

    return myLista;
  }

  Widget _crearBoton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: new RaisedButton.icon(
          label: new Text("Reservar Tour"),
          icon: new Icon(Icons.shopping_cart),
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).bottomAppBarColor,
          shape: StadiumBorder(),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CarritoCompra(
            //       tourPaqueteModel: widget.dataTourPaquete,
            //     ),
            //   ),
            // );
          }),
    );
  }

  Widget _descripcion(String descripcion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(descripcion,
              overflow: TextOverflow.ellipsis,
              maxLines: 50,
              textAlign: TextAlign.justify,
              style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey)),
        ),
      ],
    );
  }
}
