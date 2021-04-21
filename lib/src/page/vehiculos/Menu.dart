import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/categoria_model.dart';
import 'package:peliculas/src/providers/card_provider.dart';
import 'package:peliculas/src/services/vehiculo_services.dart';
import 'package:peliculas/src/widget/cardViewAutoHorizontal.dart';
import 'package:peliculas/src/widget/card_view_widget.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  //este es el stream para cambiar la imagen del centro
  final cd = new CardProvider();
  Future<List<Categoria>> futureCategorias;

  @override
  void initState() {
    super.initState();
    futureCategorias = getCategoria();
  }

  Future<List<Categoria>> getCategoria() async {
    VehiculoServices a = new VehiculoServices();
    final respuesta = await a.obtenerCategoria();
    listaCategoria = respuesta;

    if (listaCategoria.isNotEmpty) {
      cd.cambiarCard(listaCategoria[0].idcategoria);
    }

    return respuesta;
  }

  List<Categoria> listaCategoria;
  BoxDecoration boxDecorationFondo;
  Color colorCardView = Colors.white12;
  Color colorCardViewHorizontal = Colors.white10;
  //con esto se hace un switch para saber a que
  //pagina vamos a redirigir

  @override
  Widget build(BuildContext context) {
    boxDecorationFondo = BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Theme.of(context).canvasColor, Theme.of(context).canvasColor],
    ));

    return FutureBuilder(
      future: futureCategorias,
      builder: (BuildContext context, AsyncSnapshot<List<Categoria>> snapshot) {
        List<Categoria> data = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (data == null || data.isEmpty) return helper.noData();
            return cuerpo(context);
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return helper.noData();
        }
      },
    );
  }

  Container cuerpo(BuildContext context) {
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
                itemCount: listaCategoria.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardViewAutoHorizontal(
                    color: Colors.red,
                    colortexto: Theme.of(context).bottomAppBarColor,
                    index: listaCategoria[index].idcategoria,
                    assetImage: listaCategoria[index].getAsset(),
                    titulo: listaCategoria[index].nombreCategoria,
                    subtitulo: listaCategoria[index].descripcionCategoria,
                    distancia: '',
                    superficie: '',
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
      initialData: listaCategoria[0].idcategoria,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        int indexSeleccionado = snapshot.data;
        Categoria categoriaSeleccionada =
            listaCategoria.firstWhere((categoria) => categoria.idcategoria == indexSeleccionado);
        return Container(
          child: CardViewAutoView(
            colortexto: Theme.of(context).bottomAppBarColor,
            assetImage: categoriaSeleccionada.getAsset(),
            titulo: categoriaSeleccionada.nombreCategoria,
            subtitulo: categoriaSeleccionada.descripcionCategoria,
            distancia: '',
            superficie: '',
          ),
        );
      },
    );
  }

  Widget appBarCategorias() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Menú"),
    );
  }

  Widget _boton() {
    return StreamBuilder(
      stream: cd.cardStreamX,
      initialData: listaCategoria[0].idcategoria,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        int indexSeleccionado = snapshot.data;
        Categoria categoriaSeleccionada =
            listaCategoria.firstWhere((categoria) => categoria.idcategoria == indexSeleccionado);
        return FloatingActionButton.extended(
          onPressed: () {
            print(indexSeleccionado);
          },
          label: Text('Ver Flota de ${categoriaSeleccionada.nombreCategoria}'),
          icon: Icon(Icons.check),
        );
      },
    );
  }
}
