import 'package:flutter/material.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/widget/Lista.dart';

class ListaVehiculos extends StatelessWidget {
  ListaVehiculos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String argumento = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: appBarCategorias(argumento), body: _listado(context));
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
    return ListView.builder(
        itemCount: CourseList.list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "DetalleVehiculos",
                  arguments: CourseList.list[index]);
            },
            child: Column(
              children: <Widget>[
                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(model: CourseList.list[index]),
                //ESTA ES LA LINEA DE ABAJO
                Divider(
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                )
              ],
            ),
          );
        });
  }
}
