import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/DataTourPaquete_model.dart';
import 'package:peliculas/src/models/tourPaquete/InformacionAdicional_model.dart';
import 'package:peliculas/src/models/tourPaquete/TourPaquete_model.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/page/tourPaquete/CarritoCompra.dart';
import 'package:peliculas/src/widget/chip_widget.dart';
import 'package:peliculas/src/widget/descripcion_widget.dart';
import 'package:peliculas/src/widget/galeria.dart';
import 'package:peliculas/src/widget/listaHorizontal_widget.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetallePaquete extends StatefulWidget {
  final DataTourPaqueteModel dataTourPaquete;

  const DetallePaquete({@required this.dataTourPaquete});

  @override
  _DetallePaqueteState createState() => _DetallePaqueteState();
}

class _DetallePaqueteState extends State<DetallePaquete> {
  int pasoActual = 0;
  Future<InformacionAdicional> infoAdicional;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Provider.of<TurServices>(context, listen: false);

    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: scrollView(context, widget.dataTourPaquete));
  }


  Widget scrollView(BuildContext context, DataTourPaqueteModel dataTourPaquete) {
    return CustomScrollView(
      slivers: <Widget>[
        AppBarWidget(
          titulo: dataTourPaquete.nombreTours,
          imagen: transformarFoto(dataTourPaquete.foto),
          id: dataTourPaquete.idTours.toString(),
        ),
        new SliverList(
            delegate: new SliverChildListDelegate([
          new SizedBox(height: 10.0),
          helper.posterTitulo(context: context, title: dataTourPaquete.nombreTours),
          new SizedBox(height: 10.0),
          new Divider(color: Colors.grey, height: 20.0),
          helper.crearTitulo("Descripción"),
          descripcion(dataTourPaquete.descripcionForApp),
          listaHorizontal(tipo: TypeChip.azul, lista: dataTourPaquete.incluye),
          _incluye(context, dataTourPaquete),
          helper.crearTitulo("Lugares de Salida"),
          listaHorizontal(tipo: TypeChip.verde, lista: dataTourPaquete.lugarSalida),
          helper.crearTitulo("Requisitos"),
          listaHorizontal(tipo: TypeChip.anaranjado, lista: dataTourPaquete.requisitos),
          helper.crearTitulo("No incluye"),
          listaHorizontal(tipo: TypeChip.rojo, lista: dataTourPaquete.noIncluye),
          _crearBoton(context)
        ]))
      ],
    );
  }

  Widget _incluye(BuildContext context, DataTourPaqueteModel dataTourPaquete) {
    return Stepper(
      currentStep: pasoActual,
      physics: new ClampingScrollPhysics(), //SE DEBE DE AGREGAR ESTA PROPIEDAD PARA EVITAR QUE CREE UN NUEVO SCROLL
      steps: listaDeElementos(dataTourPaquete),
      onStepContinue: () {
        setState(() {
          if (pasoActual < listaDeElementos(dataTourPaquete).length - 1) {
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

  List<Step> listaDeElementos(DataTourPaqueteModel dataTourPaquete) {
    List<Step> myLista = [];
    dataTourPaquete.sitiosTuristicos.forEach((item) {
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

    dataTourPaquete.serviciosAdicionales.forEach((item) {
      myLista.add(new Step(
          title: new Text(item.nombreServicio),
          content: Column(
            children: <Widget>[
              new Text(
                item.descripcionServicio,
                textAlign: TextAlign.justify,
                // style: TextStyle(color: Colors.red),
              ),
              Galeria(galeria: item.galeria),
            ],
          ),
          state: StepState.complete,
          isActive: true));
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
              context, MaterialPageRoute(builder: (context) => CarritoCompra(tourPaqueteModel: new TourPaqueteModel (), )));
        },
      ),
    );
  }
}
