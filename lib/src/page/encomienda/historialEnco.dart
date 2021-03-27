import 'package:flutter/material.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/widget/Lista.dart';

class HistorialEncomienda extends StatelessWidget {
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
        title: Text(
          "Historial Encomienda",
        ));
  }

  Widget _listado(BuildContext context) {
    List<ListaModel> miListaPaquetes = listaInventada();
    //Posiblemente esto se convierta en futureBilder
    return ListView.builder(
        itemCount: miListaPaquetes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              ///
            },
            child: Column(
              children: <Widget>[
                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(model: miListaPaquetes[index]),
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

  List<ListaModel> listaInventada() {
    final List<ListaModel> list = [
      ListaModel(
          id: 0,
          nombre: "Se recibio la informacion",
          descripcion: "esta bien el envio",
          imagen:
              "http://www.deasociety.com/pt/wp-content/uploads/sites/2/2016/10/logocontact-1.jpg",
          tag1: "Fecha:",
          tag2: "20-07-2020"),
      ListaModel(
          id: 1,
          nombre: "En transito",
          descripcion: "Siguie bien el envio",
          tag1: "Fecha:",
          tag2: "25-07-2020",
          imagen:
              "http://www.elsalvadorvida.com/uploads/1/0/3/6/10365923/published/3.png?1563650943"),
      ListaModel(
          id: 2,
          nombre: "Entregado",
          descripcion: "Creemos que sigue bien el envio",
          tag1: "Fecha",
          tag2: "26-07-2020",
          imagen:
              "https://image.freepik.com/foto-gratis/paquete-entregado-sonriente-joven-vendedor-dando-pulgar_13339-196060.jpg"),
    ];
    return list;
  }
}
