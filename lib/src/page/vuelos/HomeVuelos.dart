import 'package:flutter/material.dart';
import 'package:peliculas/src/page/vuelos/ListaPromociones.dart';
import 'package:peliculas/src/page/vuelos/cotizarVuelo.dart';

import 'package:peliculas/src/providers/card_provider.dart';
import 'package:peliculas/src/widget/cardViewAutoHorizontal.dart';
import 'package:peliculas/src/widget/card_view_widget.dart';

class HomeVuelos extends StatefulWidget {
  @override
  _HomeVuelosState createState() => _HomeVuelosState();
}

class _HomeVuelosState extends State<HomeVuelos> {
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
        'titulo': "Promociones",
        'subtitulo': "Conoce todas las promociones y tarifas bajas en vuelos nacionales e internacionales.",
        'assetImage': AssetImage("assets/img/vuelo.png"),
        'superficie': 'Todo El Salvador',
        'distancia': '0 km',
      },
      {
        'posicion': 1,
        'titulo': "Cotizar",
        'subtitulo': "Realiza tu cotización de tenemos los mejores precios a nivel nacional",
        'assetImage': AssetImage("assets/img/cotizar-tours.png"),
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
              elementosHorizontal(),
              elementoSeleccionado(),
            ],
          ),
        ),
        appBar: appBarCategorias(context),
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

  Widget appBarCategorias(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(1.0),
      centerTitle: true,
      title: Text("Vuelos"),
    );
  }

  Widget _boton() {
    return StreamBuilder(
      stream: cd.cardStreamX,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        int posicion = snapshot.data;
        return FloatingActionButton.extended(
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () {
            switch (posicion) {
              case 0:

                ///lo ideal es crear una sola pagina y mandarle los argumentos
                ///para que dibuje deacuerdo a lo que se le envia
                ///redirigir a paquetes nacionales
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListaPromociones()));
                break;
              case 1:

                ///redirigir a paquetes intercacionales
                Navigator.push(context, MaterialPageRoute(builder: (context) => CotizaVuelo()));
                break;
              default:
            }
          },

          ///es un operador ternario para sabere cual elemento
          ///ha sido seleccionado
          label: nombreAccion(posicion),
        );
      },
    );
  }

  Widget nombreAccion(int posicion) {
    List<String> nombres = ["Ver Promociones", "Realizar Cotización"];
    return Text(nombres[posicion]);
  }
}
