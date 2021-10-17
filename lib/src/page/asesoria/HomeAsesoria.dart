import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/card_provider.dart';
import 'package:peliculas/src/widget/cardViewAutoHorizontal.dart';
import 'package:peliculas/src/widget/card_view_widget.dart';

class HomeAsesoria extends StatefulWidget {
  @override
  _HomeAsesoriaState createState() => _HomeAsesoriaState();
}

class _HomeAsesoriaState extends State<HomeAsesoria> {
  //este es el stream para cambiar la imagen del centro
  final cd = new CardProvider();

  @override
  void initState() {
    super.initState();
  }

  List listaOpciones;
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

    listaOpciones = [
      {
        'posicion': 0,
        'titulo': "Agendar Cita",
        'subtitulo':
            "Somos profesionales en El Salvador en asesoría sobre trámites migratorios hacia los Estados Unidos.",
        'assetImage': AssetImage("assets/img/cita3.png"),
        'superficie': 'Auto Familiar',
        'distancia': '0 km',
      },
      {
        'posicion': 1,
        'titulo': "Historial Citas",
        'subtitulo': "Usa esta sencilla herramienta para obtener el historial de las citas realizadas.",
        'assetImage': AssetImage("assets/img/AsesoriaHistoria.png"),
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
                itemCount: listaOpciones.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      CardViewAutoHorizontal(
                        color: Colors.red,
                        colortexto: Theme.of(context).bottomAppBarColor,
                        index: listaOpciones[index]["posicion"],
                        assetImage: listaOpciones[index]["assetImage"],
                        titulo: listaOpciones[index]["titulo"],
                        subtitulo: listaOpciones[index]["subtitulo"],
                        distancia: listaOpciones[index]["distancia"],
                        superficie: listaOpciones[index]["superficie"],
                      ),
                      listaOpciones.length != index + 1
                          ? Icon(
                              Icons.arrow_forward,
                              color: Colors.blueAccent,
                              size: 40.0,
                            )
                          : Container(),
                    ],
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
            assetImage: listaOpciones[posicion]["assetImage"],
            titulo: listaOpciones[posicion]["titulo"],
            subtitulo: listaOpciones[posicion]["subtitulo"],
            distancia: listaOpciones[posicion]["distancia"],
            superficie: listaOpciones[posicion]["superficie"],
          ),
        );
      },
    );
  }

  Widget appBarCategorias() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Asesoría Migratoria"),
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
                Navigator.pushNamed(context, 'AgendarAsesoria');

                break;
              case 1:

                ///redirigir a paquetes intercacionales
                Navigator.pushNamed(context, 'HistorialAsesoriaPage', arguments: "Historial de Citas");

                break;

              default:
            }
          },
          label: (posicion == 0) ? Text('Agendar Cita') : Text('Ver Citas'),
          icon: Icon(Icons.check),
        );
      },
    );
  }
}
