import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/TourPaquete_model.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/page/tourPaquete/DetallePaquetes.dart';
import 'package:peliculas/src/page/tourPaquete/DetalleTours.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/Lista.dart';
import 'package:intl/intl.dart';

class ListaTours extends StatelessWidget {
  final turServices = new TurServices();
  @override
  Widget build(BuildContext context) {
    final String argumento = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appBarPaquete(context, argumento),
      body: _listado(context, argumento),
    );
  }

  Widget appBarPaquete(BuildContext context, String titulo) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      centerTitle: true,
      title: Text(titulo),
    );
  }

  Widget _listado(BuildContext context, String tipo) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
        future: turServices.obtenerViaje(tipo),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print('hecho');
              return _creandoElementos(context, snapshot.data);
            case ConnectionState.active:
              print('activo');
              return Text('activo');
            case ConnectionState.waiting:
              print('esperando');
              return Center(child: CircularProgressIndicator());
            default:
              print('esperando');
              return Text('ninguno');
          }
        });
  }

  Widget _creandoElementos(BuildContext context, List<dynamic> data) {
    //Posiblemente esto se convierta en futureBilder

    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final myTourPaquete = new TourPaqueteModel.fromJson(data[index]);
          final DateFormat formatter = DateFormat('dd/MM/yyyy');
          return GestureDetector(
            onTap: () {
              if (myTourPaquete.tipo == 'Paquete Nacional' ||
                  myTourPaquete.tipo == 'Paquete Internacional')
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetallePaquete(paquete: data[index])),
                );
              else
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetalleTours(tourPaquete: myTourPaquete)),
                );
            },
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),

                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(
                  model: new ListaModel(
                      nombre: myTourPaquete.nombreTours,
                      descripcion: myTourPaquete.descripcionForApp,
                      tag1: 'Precio \$${myTourPaquete.precio.toString()}',
                      tag2: 'Fecha de Salida ' +
                          formatter.format(myTourPaquete.start),
                      imagen: transformarFoto(myTourPaquete.foto),
                      fotos: myTourPaquete.galeria,
                      id: myTourPaquete.idTours),
                ),
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
