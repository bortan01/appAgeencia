import 'package:flutter/material.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/widget/cource_info_widget.dart';

class EncomiendasRealizadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPaquete(),
      body: _listado(context),
    );
  }

  Widget appBarPaquete() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Historial de Encomiendas"),
    );
  }

  Widget _listado(BuildContext context) {
    List<CourseModel> miListaPaquetes = listaInventada();
    //Posiblemente esto se convierta en futureBilder
    return ListView.builder(
        itemCount: miListaPaquetes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "HistoEncomienda",
                  arguments: miListaPaquetes[index]);
            },
            child: Column(
              children: <Widget>[
                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                CourceInfoWidget(model: miListaPaquetes[index]),
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

  List<CourseModel> listaInventada() {
    final List<CourseModel> list = [
      CourseModel(
          id: 0,
          nombre: "KIT DE MEDICAMENTOS",
          descripcion:
              "Envío a: Juan Perez, dirección: 2da av. sur, numero 41, Barrio San Francisco",
          imagen:
              "https://i.pinimg.com/originals/a9/b5/5f/a9b55fbd087786cb95a7c1cf14de338b.jpg",
          tag1: "Fecha: 02-03-2020",
          tag2: "Precio: \$\28.50"),
      CourseModel(
          id: 1,
          nombre: "INSULINA",
          descripcion:
              "Envío a: Juan Perez, dirección: 2da av. sur, numero 41, Barrio San Francisco",
          tag1: "Fecha: 02-03-2020",
          tag2: "Precio: \$\348.50",
          imagen:
              "https://cofatuc.org.ar/wordpress/wp-content/uploads/2017/10/insulina.jpg"),
      CourseModel(
          id: 2,
          nombre: "GLUCOMETRO",
          descripcion:
              "Envío a: Juan Perez, dirección: 2da av. sur, numero 41, Barrio San Francisco",
          tag1: "Fecha: 02-03-2020",
          tag2: "Precio: \$\348.50",
          imagen:
              "https://www.revistaneo.com/sites/default/files/2019-11/Nuevo%20sistema%20de%20administraci%C3%B3n%20de%20insulina.jpg"),
      CourseModel(
          id: 3,
          nombre: "DOCUMENTOS PERSONALES",
          descripcion:
              "Envío a: Juan Perez, dirección: 2da av. sur, numero 41, Barrio San Francisco",
          tag1: "Fecha: 02-03-2020",
          tag2: "Precio: \$\21.50",
          imagen:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQpHLXX5Np9yzG-IO3Yw9hvbQur3IyqknVgvg&usqp=CAU"),
    ];
    return list;
  }
}
