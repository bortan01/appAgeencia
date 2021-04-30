import 'package:flutter/material.dart';
import 'package:peliculas/src/models/encomienda/historialEncomienda_model.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/services/encomienda_services.dart';
import 'package:peliculas/src/widget/Lista.dart';
import 'package:intl/intl.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class HistorialEncomienda extends StatelessWidget {
  final _encomiendaServices = new EncomiendaServices();
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
        future: _encomiendaServices.obtenerHistorial(),
        builder: (BuildContext context, AsyncSnapshot<HistorialEncomiendaModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null) return helper.noData();
              return _creandoElementos(context, snapshot.data.encomiendasRealizadas);
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return helper.noData();
          }
        });
  }

  Widget _creandoElementos(BuildContext context, List<EncomiendaRealizada> data) {
    //Posiblemente esto se convierta en futureBilder

    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final DateFormat formatter = DateFormat('dd/MM/yyyy');
          return GestureDetector(
            onTap: () {},
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),

                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(
                  model: new ListaModel(
                      nombre: '',
                      descripcion: '',
                      tag1: '',
                      tag2: '',
                      imagen: '',
                      fotos: [],
                      id: int.parse(data[index].idEncomienda)),
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
