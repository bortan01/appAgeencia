import 'package:flutter/material.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/cource_info_widget.dart';
import 'package:intl/intl.dart';

class ListaTours extends StatelessWidget {
  final turServices = new TurServices();
  @override
  Widget build(BuildContext context) {
    final String argumento = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appBarPaquete(context, argumento),
      body: _listado(context),
    );
  }

  Widget appBarPaquete(BuildContext context, String argumento) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      centerTitle: true,
      title: Text("Tours: " + argumento),
    );
  }

  Widget _listado(BuildContext context) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
        future: turServices.obtenerTur(),
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
          final fecha = DateTime.parse(data[index]['start']);
          final DateFormat formatter = DateFormat('dd/MM/yyyy');
          final String fechaFormateada = formatter.format(fecha);
          final tur = new CourseModel(
              id: int.parse(data[index]['id_tours']),
              nombre: data[index]['nombreTours'],
              descripcion: data[index]['descripcionForApp'],
              imagen: transformarFoto(data[index]['foto']),
              tag1: "Precio \$" + data[index]['precio'],
              tag2: 'Fecha de Salida ' + fechaFormateada);
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "DetalleTours",
                  arguments: data[index]);
            },
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),

                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                CourceInfoWidget(model: tur),
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
