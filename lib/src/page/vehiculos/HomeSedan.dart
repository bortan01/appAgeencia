import 'package:flutter/material.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/widget/cource_info_widget.dart';

class HomeSedan extends StatelessWidget {
  HomeSedan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String argumento = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Column(
        children: <Widget>[appBarCategorias(argumento), _listado(context)],
      ),
    )));
  }

  Widget appBarCategorias(String argumento) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Categoría: " + argumento),
    );
  }

  Widget _listado(BuildContext context) {
    //Posiblemente esto se convierta en futureBilder
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _items(CourseList.list, context),
        ),
      ),
    );
  }

  List<Widget> _items(List<CourseModel> lista, BuildContext context) {
    List<Widget> elementos = [];

    for (var i = 0; i < lista.length; i++) {
      final elementoTemporal = GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "DetalleVehiculos", arguments: lista[i]);
          //print("ddddd");
        },

        ///aqui se dibuja el elemento
        child: CourceInfoWidget(
          model: CourseList.list[i],
        ),
      );
      final dividerTempooral = Divider(
        thickness: 1,
        endIndent: 20,
        indent: 20,
      );
      elementos.add(elementoTemporal);
      elementos.add(dividerTempooral);
    }
    return elementos;
  }
}
