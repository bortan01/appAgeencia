import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/card_provider.dart';
import 'package:peliculas/src/widget/cardViewAutoHorizontal.dart';
import 'package:peliculas/src/widget/card_view_widget.dart';

class MenuProductos extends StatefulWidget {
  MenuProductos({Key key}) : super(key: key);

  @override
  _MenuProductosState createState() => _MenuProductosState();
}

class _MenuProductosState extends State<MenuProductos> {
  final cd = new CardProvider();

  @override
  void initState() {
    super.initState();
  }

  int redireccionPagina = 0;
  List listaPaquete;
  BoxDecoration boxDecorationFondo;
  Color colorCardView = Colors.white12;
  Color colorCardViewHorizontal = Colors.white10;

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
        'titulo': "Historial de Viajes",
        'subtitulo':
            "En esta seccion encontraras todos los viajes que haz realizado con nosotros is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the ",
        'assetImage': AssetImage("assets/img/paquete-nacional.png"),
        'superficie': 'Todo El Salvador',
        'distancia': '0 km',
      },
      {
        'posicion': 1,
        'titulo': "Historial de Vehiculos",
        'subtitulo':
            "En esta seccion encontraras todos los vehiculos que has rentado con la ayuda de nuestra agencia It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout",
        'assetImage': AssetImage("assets/img/sedan1.png"),
        'superficie': 'Sub-America y Europa',
        'distancia': ' 57,91 millones km',
      },
      {
        'posicion': 2,
        'titulo': "Historial de Encomiendas",
        'subtitulo': "Usa esta sencilla herramienta para obtener el historial de encomiendas realizadas.",
        'assetImage': AssetImage("assets/img/cotizar.png"),
        'superficie': '74,8 millones km²',
        'distancia': ' 57,91 millones km',
      }
    ];

    return Container(
      decoration: boxDecorationFondo,
      child: Scaffold(
        appBar: appBarCategorias(),
        body: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              elementosHorizontal(),
              elementoSeleccionado(),
            ],
          ),
        ),
        floatingActionButton: _boton(context, redireccionPagina),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      stream: cd.cardStreamX,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        int posicion = snapshot.data;
        redireccionPagina = posicion;
        //print("creando objeto");
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
      title: Text("Productos Adquiridos"),
    );
  }

  Widget _boton(BuildContext context, int redireccionPagina) {
    return StreamBuilder(
      stream: cd.cardStreamX,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        int posicion = snapshot.data;
        return FloatingActionButton.extended(
          onPressed: () {
            switch (posicion) {
              case 0:

                ///lo ideal es crear una sola pagina y mandarle los argumentos
                ///para que dibuje deacuerdo a lo que se le envia

                ///redirigir a paquetes nacionales
                Navigator.pushNamed(context, 'TourPaqueteHistorial');

                break;
              case 1:

                ///redirigir a paquetes intercacionales
                Navigator.pushNamed(context, 'carrosAlqui');

                break;

              case 2:
                Navigator.pushNamed(context, 'HistoEncomienda', arguments: "Historial de Encomiendas");

                break;

              default:
            }
          },
          label: nombreHistorial(posicion),
        );
      },
    );
  }

  Widget nombreHistorial(int posicion) {
    List<String> nombres = [
      "Ver historial de Viajes",
      "Ver historial de Vehiculos",
      "Ver historial de Encomiendas",
    ];
    return Text(nombres[posicion]);
  }
}
