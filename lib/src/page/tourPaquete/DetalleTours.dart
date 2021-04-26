import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/InformacionAdicional_model.dart';
import 'package:peliculas/src/models/tourPaquete/TourPaquete_model.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/page/tourPaquete/CarritoCompra.dart';
import 'package:peliculas/src/widget/chip_widget.dart';
import 'package:peliculas/src/widget/galeria.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetalleTours extends StatefulWidget {
  final TourPaqueteModel tourPaquete;
  const DetalleTours({@required this.tourPaquete});

  @override
  _DetalleToursState createState() => _DetalleToursState();
}

class _DetalleToursState extends State<DetalleTours> {
  int pasoActual = 0;
  Future infoAdicional;

  @override
  void initState() {
    super.initState();
    infoAdicional = _getInfoAdicional();
  }

  Future<dynamic> _getInfoAdicional() async {
    return await TurServices().obtenerInformacionAdicional(widget.tourPaquete.idTours.toString());
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TurServices>(context, listen: false);
    // final dynamic tur = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: detalle(context));
  }

  Widget detalle(BuildContext context) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
        future: infoAdicional,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print('hecho');
              if (snapshot.data == null) return helper.noData();
              final informacionAcicional = snapshot.data;
              return scrollView(context, informacionAcicional, widget.tourPaquete);
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return helper.noData();
          }
        });
  }

  Widget scrollView(BuildContext context, InformacionAdicional informacionAdicional, TourPaqueteModel tur) {
    return CustomScrollView(
      slivers: <Widget>[
        AppBarWidget(
          titulo: widget.tourPaquete.nombreTours,
          imagen: transformarFoto(widget.tourPaquete.foto),
          id: widget.tourPaquete.idTours.toString(),
        ),
        new SliverList(
            delegate: new SliverChildListDelegate([
          new SizedBox(
            height: 10.0,
          ),
          _posterTitulo(
              context: context, title: widget.tourPaquete.nombreTours, fecha: widget.tourPaquete.start.toString()),
          new SizedBox(height: 10.0),
          new Divider(
            color: Colors.grey,
            height: 20.0,
          ),
          _descripcion(tur.descripcionForApp),
          listaHorizontal(tipo: TypeChip.azul, lista: tur.incluye),
          helper.crearTitulo("Lugares de Salida"),
          listaHorizontal(tipo: TypeChip.verde, lista: tur.lugarSalida),
          helper.crearTitulo("Requisitos"),
          listaHorizontal(tipo: TypeChip.anaranjado, lista: tur.requisitos),
          helper.crearTitulo("No incluye"),
          listaHorizontal(tipo: TypeChip.rojo, lista: tur.noIncluye),
          _crearBoton(context)
        ]))
      ],
    );
  }

  _posterTitulo({@required BuildContext context, @required String title, @required String fecha}) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          new SizedBox(
            width: 20.0,
          ),
          new Flexible(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: new Text(title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ))
        ],
      ),
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
      child: new RaisedButton.icon(
          label: new Text("Reservar Tour"),
          icon: new Icon(Icons.shopping_cart),
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).bottomAppBarColor,
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CarritoCompra(
                          tourPaqueteModel: widget.tourPaquete,
                        )));
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
