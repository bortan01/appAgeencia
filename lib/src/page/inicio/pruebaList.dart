import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:peliculas/src/widget/card_view_widget.dart';

class PruebaList extends StatefulWidget {
  PruebaList({Key key}) : super(key: key);

  @override
  _PruebaListState createState() => _PruebaListState();
}

class _PruebaListState extends State<PruebaList> {
  AnimationController animateController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElasticInDown(
      child: SpinPerfect(
          // manualTrigger: true,

          //(optional, but mandatory if you use manualTrigger:true) This callback exposes the AnimationController used for the selected animation. Then you can call animationController.forward() to trigger the animation wherever you like manually.
          controller: (controller) => animateController = controller,
          child: _imagen()),
    )));
  }

  _imagen() {
    List listaPaquete;
    listaPaquete = [
      {
        'posicion': 0,
        'titulo': "Sedan",
        'subtitulo':
            "Una característica clave en un sedán es la seguridad que aporta. Los frenos antibloqueo son la primera línea de defensa ante cualquier accidente. Al momento de la colisión, las bolsas de aire pueden salvar la vida de tus pasajeros.",
        'assetImage': AssetImage("assets/img/sedan1.png"),
        'superficie': 'Auto Familiar',
        'distancia': '0 km',
      },
      {
        'posicion': 1,
        'titulo': "Camionetas",
        'subtitulo':
            "Empleado generalmente para el transporte de mercancías, un término que hoy en día se aplica a veces informalmente a distintos tipos de automóviles, en concreto pickups, vehículos todoterreno, furgonetas, monovolúmenes, y familiares.",
        'assetImage': AssetImage("assets/img/camioneta.png"),
        'superficie': '74,8 millones km²',
        'distancia': ' 57,91 millones km',
      },
      {
        'posicion': 2,
        'titulo': "Pickup",
        'subtitulo':
            "Empleado generalmente para el transporte de mercancías, y que tiene en su parte trasera una zona de carga descubierta (denominada caja, batea, balde, carrocería, platón, cama o palangana), en la cual se pueden colocar objetos grandes.",
        'assetImage': AssetImage("assets/img/pickup.png"),
        'superficie': '460,2 millones km²',
        'distancia': '108,2 millones km',
      },
      {
        'posicion': 3,
        'titulo': "Microbus",
        'subtitulo':
            "Gran furgoneta que tiene asientos en la parte posterior para los pasajeros y ventanas a los lados.",
        'assetImage': AssetImage("assets/img/1.png"),
        'superficie': '510,1 millones km²',
        'distancia': '149,6 millones km',
      },
      {
        'posicion': 4,
        'titulo': "Minivans",
        'subtitulo':
            "Ofrece características aptas para la familia, además de toda la tecnología que se podría desear en un paquete atractivo y a un precio muy conveniente.",
        'assetImage': AssetImage("assets/img/1.png"),
        'superficie': '144,8 millones km²',
        'distancia': '227,9 millones km',
      },
    ];

    return Container(
      child: CardViewAutoView(
        colortexto: Theme.of(context).bottomAppBarColor,
        assetImage: listaPaquete[0]["assetImage"],
        titulo: listaPaquete[0]["titulo"],
        subtitulo: listaPaquete[0]["subtitulo"],
        distancia: listaPaquete[0]["distancia"],
        superficie: listaPaquete[0]["superficie"],
      ),
    );
  }
}
