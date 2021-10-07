import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vuelos/CotizacionVueloRealizada_model.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/vuelos_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class CotizacionVueloRealizadaPage extends StatelessWidget {
  final VuelosServices _vueloServices = new VuelosServices();
  final PreferenciasUsuario _pref = new PreferenciasUsuario();
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
        future: _vueloServices.obtenerCotizacionesRealizadas(_pref.idCliente),
        builder: (BuildContext context, AsyncSnapshot<CotizacionVueloRealizadaModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null || snapshot.data.informacion.isEmpty) return helper.noData();
              return _creandoElementos(context, snapshot.data.informacion);
            case ConnectionState.active:
              return helper.waitingData();
            case ConnectionState.waiting:
              return helper.waitingData();
            default:
              return helper.noData();
          }
        });
  }

  Widget _creandoElementos(BuildContext context, List<Informacion> data) {
    //Posiblemente esto se convierta en futureBilder

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _peticion(data[index]);
      },
    );
  }

  Widget _peticion(Informacion cotizacion) {
    String respuesta;
    if (cotizacion.total != "0") {
      respuesta = 'Respuesta de Cotización: ${cotizacion.total}';
    } else {
      respuesta = 'Sin Respuesta';
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          helper.crearTitulo('Ciudad de Partida'),
          _descripcion(cotizacion.ciudadPartida),
          helper.crearTitulo('Ciudad de Llegada'),
          _descripcion(cotizacion.ciudadLlegada),
          helper.crearTitulo('Aerolinea'),
          _descripcion(cotizacion.nombreAerolinea),
          helper.crearTitulo('Opciones Avanzadas'),
          _descripcion(cotizacion.opcAvanzadas.toString()),
          helper.crearTitulo("Respuesta de Cotización"),
          _descripcion(respuesta),
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
        textAlign: TextAlign.center,
        style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey),
      ),
    );
  }
}
