import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/cotizacionesByClient_model.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class CotizacionesPaquetesPage extends StatelessWidget {
  final turServices = new TurServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPaquete(context),
      body: _listado(context),
    );
  }

  Widget appBarPaquete(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      centerTitle: true,
      title: Text("Cotizaciones Realizadas"),
    );
  }

  Widget _listado(BuildContext context) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
        future: turServices.obtenerCotizacionesByCliente(),
        builder: (BuildContext context, AsyncSnapshot<CotizacionesPaquetesCliente> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null || snapshot.data.cotizaciones.isEmpty) return helper.noData();
              return _creandoElementos(context, snapshot.data.cotizaciones);
            case ConnectionState.active:
              return helper.waitingData();
            case ConnectionState.waiting:
              return helper.waitingData();
            default:
              return helper.noData();
          }
        });
  }

  Widget _creandoElementos(BuildContext context, List<Cotizacione> data) {
    //Posiblemente esto se convierta en futureBilder

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _peticion(data[index]);
      },
    );
  }

  Widget _peticion(Cotizacione cotizacion) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          helper.crearTitulo('Fecha Solicitada'),
          _descripcion(helper.transformarFecha(cotizacion.fechaPeticion)),
          helper.crearTitulo('Solicitud'),
          _descripcion(cotizacion.peticion),
          helper.crearTitulo("Respuesta de Solicitud"),
          _descripcion(cotizacion.respuesta),
          //ESTA ES LA LINEA DE ABAJO
          Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          )
        ],
      ),
    );
  }

  Widget _descripcion(String texto) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        texto,
        overflow: TextOverflow.ellipsis,
        maxLines: 87,
        textAlign: TextAlign.justify,
        style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey),
      ),
    );
  }
}
