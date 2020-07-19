import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/card_provider.dart';
import 'package:peliculas/src/widget/cardViewAutoHorizontal.dart';
import 'package:peliculas/src/widget/card_view_widget.dart';

class HomeCategoria extends StatefulWidget {
  @override
  _HomeCategoriaState createState() => _HomeCategoriaState();
}

class _HomeCategoriaState extends State<HomeCategoria> {
  //este es el stream para cambiar la imagen del centro
  final cd = new CardProvider();

  @override
  void initState() {
    super.initState();
  }

  List listaPaquete;
  BoxDecoration boxDecorationFondo;
  Color colorCardView = Colors.white12;
  Color colorCardViewHorizontal = Colors.white10;
  //con esto se hace un switch para saber a que
  //pagina vamos a redirigir

  @override
  Widget build(BuildContext context) {
    cd.cambiarCard(0);

    boxDecorationFondo = BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Theme.of(context).canvasColor, Theme.of(context).canvasColor],
    ));

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
      decoration: boxDecorationFondo,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              appBarCategorias(),
              elementosHorizontal(),
              elementoSeleccionado(),
            ],
          ),
        ),
        floatingActionButton: _boton(),
      ),
    );
  }

  Widget elementosHorizontal() {
    return SizedBox(
      height: 100.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            /* Flexible : Un widget que controla cómo se flexiona un hijo de una Fila , Columna o Flex . */
            /* Iteramos la lista horizontal de los cuerpos del vehiculos */
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listaPaquete.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardViewAutoHorizontal(
                    color: Colors.red,
                    colortexto: Theme.of(context).bottomAppBarColor,
                    index: listaPaquete[index]["posicion"],
                    assetImage: listaPaquete[index]["assetImage"],
                    titulo: listaPaquete[index]["titulo"],
                    subtitulo: listaPaquete[index]["subtitulo"],
                    distancia: listaPaquete[index]["distancia"],
                    superficie: listaPaquete[index]["superficie"],
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget elementoSeleccionado() {
    return StreamBuilder(
      //este es el stream al que se esta escuchando
      stream: cd.cardStreamX,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        int posicion = snapshot.data;
        return Container(
          child: CardViewAutoView(
            colortexto: Theme.of(context).bottomAppBarColor,
            assetImage: listaPaquete[posicion]["assetImage"],
            titulo: listaPaquete[posicion]["titulo"],
            subtitulo: listaPaquete[posicion]["subtitulo"],
            distancia: listaPaquete[posicion]["distancia"],
            superficie: listaPaquete[posicion]["superficie"],
          ),
        );
      },
    );
  }

  Widget appBarCategorias() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Categoría de Paquetes"),
    );
  }

  Widget _boton() {
    return StreamBuilder(
      stream: cd.cardStreamX,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return FloatingActionButton.extended(
          onPressed: () {
            int posicion = snapshot.data;
            switch (posicion) {
              case 0:

                ///lo ideal es crear una sola pagina y mandarle los argumentos
                ///para que dibuje deacuerdo a lo que se le envia

                ///redirigir a paquetes nacionales
                Navigator.pushNamed(context, 'HomeSedan', arguments: "Sedan");

                break;
              case 1:

                ///redirigir a paquetes intercacionales
                Navigator.pushNamed(context, 'HomeSedan',
                    arguments: "Camionetas");

                break;
              case 2:

                ///redirigir a paquetes intercacionales
                Navigator.pushNamed(context, 'HomeSedan', arguments: "Pickup");

                break;
              case 3:

                ///redirigir a paquetes intercacionales
                Navigator.pushNamed(context, 'HomeSedan',
                    arguments: "Microbus");

                break;
              case 4:

                ///redirigir a paquetes intercacionales
                Navigator.pushNamed(context, 'HomeSedan',
                    arguments: "Minivans");

                break;
              default:
            }
          },
          label: Text('Ver Flota de Vehículos'),
          icon: Icon(Icons.check),
        );
      },
    );
  }
}
