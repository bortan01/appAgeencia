import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/card_provider.dart';
import 'package:peliculas/src/widget/cardViewAutoHorizontal.dart';
import 'package:peliculas/src/widget/card_view_widget.dart';

class MenuEncomienda extends StatefulWidget {
  @override
  _HomeCategoriaState createState() => _HomeCategoriaState();
}

class _HomeCategoriaState extends State<MenuEncomienda> {
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
        'titulo': "Cotizar Encomienda",
        'subtitulo':
            "Cotizador de envíos de encomiendas para conocer las tarifas ingresando todos los datos solicitados para realizar la cotización. ¡Cotiza ahora!",
        'assetImage': AssetImage("assets/img/historial.png"),
        'superficie': 'Auto Familiar',
        'distancia': '0 km',
      },
      {
        'posicion': 1,
        'titulo': "Historial Encomiendas",
        'subtitulo': "Usa esta sencilla herramienta para obtener el historial de encomiendas realizadas.",
        'assetImage': AssetImage("assets/img/cotizar.png"),
        'superficie': '74,8 millones km²',
        'distancia': ' 57,91 millones km',
      },
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
        floatingActionButton: _boton(),
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
      title: Text("Encomiendas"),
    );
  }

  Widget _boton() {
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
                Navigator.pushNamed(context, 'encomienda', arguments: "Cotización");

                break;
              case 1:

                ///redirigir a paquetes intercacionales
                Navigator.pushNamed(context, 'HistoEncomienda', arguments: "Historial de Encomiendas");

                break;

              default:
            }
          },
          label: (posicion == 0) ? Text('Cotizar Encomiendas') : Text('Ver Historial'),
          icon: Icon(Icons.check),
        );
      },
    );
  }
}
