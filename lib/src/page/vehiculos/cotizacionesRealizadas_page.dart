import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/cotizacionesRealizadas.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/services/vehiculo_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class CotizacionesRealizadasPage extends StatelessWidget {
  final _vehiculoServices = new VehiculoServices();
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
        future: _vehiculoServices.cotizacionesByCliente(),
        builder: (BuildContext context, AsyncSnapshot<CotizacionesRealizadas> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null || snapshot.data.cotizacion.isEmpty) return helper.noData();
              return _creandoElementos(context, snapshot.data.cotizacion);
            case ConnectionState.active:
              return helper.waitingData();
            case ConnectionState.waiting:
              return helper.waitingData();
            default:
              return helper.noData();
          }
        });
  }

  Widget _creandoElementos(BuildContext context, List<Cotizacion> data) {
    //Posiblemente esto se convierta en futureBilder

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _peticion(data[index]);
      },
    );
  }

  Widget _peticion(Cotizacion cotizacion) {
    String respuesta;
    if (cotizacion.respuestaCotizacion != "") {
      respuesta = cotizacion.respuestaCotizacion;
    } else {
      respuesta = 'Sin Respuesta';
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          helper.crearTitulo('Información de Recogida'),
          _descripcion(cotizacion.direccionRecogida +
              ", " +
              helper.transformarFecha(cotizacion.fechaRecogida) +
              " " +
              cotizacion.horaRecogida),

          helper.crearTitulo('Información de Devolución'),
          _descripcion(cotizacion.direccionDevolucion +
              ", " +
              helper.transformarFecha(cotizacion.fechaDevolucion) +
              " " +
              cotizacion.horaDevolucion),
          helper.crearTitulo('Modelo y Año'),
          _descripcion(cotizacion.modelo + " " + cotizacion.anio),

          helper.crearTitulo('Características'),
          _descripcion(cotizacion.caracteristicas),
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
