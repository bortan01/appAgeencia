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

    boxDecorationFondo = BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Theme.of(context).canvasColor, Theme.of(context).canvasColor],
    ));

    listaPaquete = [
      {
        'posicion': 0,
        'titulo': "Nacionales",
        'subtitulo':
            "Haz realidad tus sueños con nuestros paquetes turísticos visitando los lugares mas hermonos de nuestro lindo El Salvador",
        'assetImage': AssetImage("assets/img/paquete_internacional.png"),
        'superficie': 'Todo El Salvador',
        'distancia': '0 km',
      },
      {
        'posicion': 1,
        'titulo': "Internacionales",
        'subtitulo':
            "Ven y Haz realidad tus sueños con nuestros paquetes turísticos para Centro América, Sudamérica y Europa",
        'assetImage': AssetImage("assets/img/internacional.png"),
        'superficie': 'Sub-America y Europa',
        'distancia': ' 57,91 millones km',
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
          label: Text('Ver Paquetes'),
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
