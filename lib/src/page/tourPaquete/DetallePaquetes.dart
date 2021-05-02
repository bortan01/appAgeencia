import 'package:flutter/material.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/models/tourPaquete/InformacionAdicional_model.dart';
import 'package:peliculas/src/models/tourPaquete/TourPaquete_model.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/page/tourPaquete/CarritoCompra.dart';
import 'package:peliculas/src/widget/chip_widget.dart';
import 'package:peliculas/src/widget/galeria.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetallePaquete extends StatefulWidget {
  final TourPaqueteModel tourPaquete;

  const DetallePaquete({@required this.tourPaquete});

  @override
  _DetallePaqueteState createState() => _DetallePaqueteState();
}

class _DetallePaqueteState extends State<DetallePaquete> {
  int pasoActual = 0;
  Future<InformacionAdicional> infoAdicional;

  @override
  void initState() {
    super.initState();
    infoAdicional = _getInfoAdicional();
  }

  Future<InformacionAdicional> _getInfoAdicional() async {
    return await TurServices().obtenerInformacionAdicional(widget.tourPaquete.idTours.toString());
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TurServices>(context, listen: false);

    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: detalle(context, widget.tourPaquete));
  }

  Widget detalle(BuildContext context, TourPaqueteModel tur) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
        future: infoAdicional,
        builder: (BuildContext context, AsyncSnapshot<InformacionAdicional> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final informacionAcicional = snapshot.data;
              return scrollView(context, informacionAcicional, tur);
            case ConnectionState.active:
              return helper.waitingData();
            case ConnectionState.waiting:
              print('esperando');
              return helper.waitingData();
            default:
              return helper.noData();
          }
        });
  }

  Widget scrollView(BuildContext context, InformacionAdicional informacionAdicional, TourPaqueteModel tur) {
    return CustomScrollView(
      slivers: <Widget>[
        AppBarWidget(
          titulo: 'Detalle paquete' + tur.nombreTours,
          imagen: transformarFoto(tur.foto),
          id: tur.idTours.toString(),
        ),
        new SliverList(
            delegate: new SliverChildListDelegate([
          new SizedBox(
            height: 10.0,
          ),
          helper.posterTitulo(context: context, title: tur.nombreTours, fecha: tur.start.toString()),
          new SizedBox(height: 10.0),
          new Divider(
            color: Colors.grey,
            height: 20.0,
          ),
          helper.crearTitulo("Descripción"),
          _descripcion(tur.descripcionForApp),
          listaHorizontal(tipo: TypeChip.azul, lista: tur.incluye),
          _incluye(context, informacionAdicional),
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

  Widget _incluye(BuildContext context, InformacionAdicional informacionAdicional) {
    return Stepper(
      currentStep: pasoActual,
      physics: new ClampingScrollPhysics(), //SE DEBE DE AGREGAR ESTA PROPIEDAD PARA EVITAR QUE CREE UN NUEVO SCROLL
      steps: listaDeElementos(informacionAdicional),
      onStepContinue: () {
        setState(() {
          if (pasoActual < listaDeElementos(informacionAdicional).length - 1) {
            pasoActual++;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (pasoActual > 0) {
            pasoActual--;
          }
        });
      },
      controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(
          children: <Widget>[
            FlatButton(
              onPressed: onStepContinue,
              color: (Theme.of(context).accentColor),
              child: const Text(
                'SIGUIENTE',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            FlatButton(
              onPressed: onStepCancel,
              color: (Theme.of(context).accentColor),
              child: const Text(
                'ATRAS',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
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

  List<Step> listaDeElementos(InformacionAdicional informacionAdicional) {
    List<Step> myLista = [];
    informacionAdicional.sitiosTuristicos.forEach((item) {
      myLista.add(
        new Step(
            title: new Text(item.nombreSitio),
            content: Column(
              children: <Widget>[
                new Text(
                  item.descripcionSitio,
                  textAlign: TextAlign.justify,
                ),
                Galeria(galeria: item.galeria),
              ],
            ),
            state: StepState.complete,
            isActive: true),
      );
    });

    informacionAdicional.serviciosAdicionales.forEach((item) {
      myLista.add(
        new Step(
            title: new Text(item.nombreServicio),
            content: Column(
              children: <Widget>[
                new Text(
                  item.descripcionServicio,
                  textAlign: TextAlign.justify,
                ),
                Galeria(
                  galeria: item.galeria,
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
          label: new Text("Reservar Paquete"),
          icon: new Icon(Icons.shopping_cart),
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).bottomAppBarColor,
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CarritoCompra(tourPaqueteModel: widget.tourPaquete)));
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
