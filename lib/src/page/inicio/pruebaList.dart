import 'package:flutter/material.dart';
import 'package:peliculas/src/widget/cource_info_widget.dart';
import 'modelo/ModeloInformacion.dart';

class PruebaList extends StatelessWidget {
  PruebaList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Column(
        children: <Widget>[appBarCategorias(), _listado()],
      ),
    )));
  }

  Widget appBarCategorias() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Categoría: Sedan"),
    );
  }

  Widget _listado() {
    //Posiblemente esto se convierta en futureBilder
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _items(CourseList.list),
        ),
      ),
    );
  }

  List<Widget> _items(List<CourseModel> lista) {
    List<Widget> elementos = [];

    for (var i = 0; i < lista.length; i++) {
      final elementoTemporal = GestureDetector(
        onTap: () {
          print(
              "tocando el objejto con id " + CourseList.list[i].id.toString());
        },
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
