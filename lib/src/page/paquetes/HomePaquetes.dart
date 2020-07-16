import 'package:flutter/material.dart';
import 'package:peliculas/src/page/vehiculos/HomeVehiculos.dart';
import 'package:peliculas/src/providers/card_provider.dart';
import 'package:peliculas/src/widget/cardViewAutoHorizontal.dart';
import 'package:peliculas/src/widget/card_view_widget.dart';

class HomePaquetes extends StatefulWidget {
  @override
  _PagelistaVehiculostate createState() => _PagelistaVehiculostate();
}

class _PagelistaVehiculostate extends State<HomePaquetes> {
  final cardProvi = new CardProvider();

  List listaPaquete;
  BoxDecoration boxDecorationFondo;
  Color colorCardView = Colors.white12;
  Color colorCardViewHorizontal = Colors.white10;

  @override
  Widget build(BuildContext context) {
    //para inicializar en el valor 0
    cardProvi.cambiarCard(0);

    boxDecorationFondo = Theme.of(context).brightness == Brightness.dark
        ? BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).canvasColor,
              Theme.of(context).canvasColor
            ],
          ))
        : BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(253, 254, 254, 1.0),
              Color.fromRGBO(214, 234, 248, 1.0)
            ],
          ));
    listaPaquete = [
      {
        'posicion': 0,
        'titulo': "Nacionales",
        'subtitulo':
            "Una característica clave en un sedán es la seguridad que aporta. Los frenos antibloqueo son la primera línea de defensa ante cualquier accidente. Al momento de la colisión, las bolsas de aire pueden salvar la vida de tus pasajeros.",
        'assetImage': AssetImage("assets/img/paquete_internacional.png"),
        'superficie': 'Auto Familiar',
        'distancia': '0 km',
      },
      {
        'posicion': 1,
        'titulo': "Internacionales",
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
              vehiculosPopulares(),
              ////aqui tengo que poner un streamBuilder
              StreamBuilder(
                stream: cardProvi.cardStreamX,
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  ///este es el principal que aparece en el centro
                  int posicion = snapshot.data;
                  print("redibujado en la posicion" + posicion.toString());
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
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeVehiculos()),
            );
            // Add your onPressed code here!
          },
          label: Text('Ver autos'),
          icon: Icon(Icons.check),
        ),
      ),
    );
  }

  Widget vehiculosPopulares() {
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

  Widget appBarCategorias() {
    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        );
      }),
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Categoría de Vehiculos"),
    );
  }
}
