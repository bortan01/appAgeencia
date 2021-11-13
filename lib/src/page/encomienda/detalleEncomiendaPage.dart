import 'package:flutter/material.dart';
import 'package:peliculas/src/models/encomienda/detalleEncomienda_model.dart';
import 'package:peliculas/src/models/encomienda/historialEncomienda_model.dart';
import 'package:peliculas/src/services/encomienda_services.dart';
import 'package:intl/intl.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetalleEncomiendaPage extends StatelessWidget {
  final _encomiendaServices = new EncomiendaServices();
  @override
  Widget build(BuildContext context) {
    final EncomiendaRealizada encomiendaRealizada = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appBarPaquete(context, encomiendaRealizada.nombreMunicipio),
      body: _listado(context, encomiendaRealizada.idEncomienda),
    );
  }

  Widget appBarPaquete(BuildContext context, String titulo) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      centerTitle: true,
      title: Text(titulo),
    );
  }

  Widget _listado(BuildContext context, String idEncomienda) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
      future: _encomiendaServices.obtenerDetalle(idEncomienda),
      builder: (BuildContext context, AsyncSnapshot<DetalleEncomienda> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data == null || snapshot.data.actualizaciones.isEmpty) return helper.noData();
            return _crearHistorial(context, snapshot.data.actualizaciones);
          // return _creandoElementos(context, snapshot.data);
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

  Widget _crearHistorial(BuildContext context, List<ActualizacionEncomienda> listActualizacion) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return ListView.builder(
      itemCount: listActualizacion.length,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          padding: EdgeInsets.all(5.0),
          margin: new EdgeInsets.only(
            top: 15.0,
            right: 20.0,
            left: 20.0,
          ),
          decoration: new BoxDecoration(
            color: Color(0xFF4B9DFE),
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(4.0),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black12, blurRadius: 10.0, offset: Offset(0.0, 8.0))
            ], /* Aplica sombra */
          ),
          child: Container(
            /* Margen del contenido */
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.check, color: Colors.white),
                      margin: EdgeInsets.all(5.0),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: new Text(listActualizacion[index].descripcion,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                          overflow: TextOverflow.ellipsis),
                    ),
                    new SizedBox(height: 5.0),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: Text(
                    formatter.format(listActualizacion[index].fecha),
                    maxLines: 20,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
