import 'package:flutter/material.dart';
import 'package:peliculas/src/models/asesoria/HistoriaAsesoria_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/asesoria_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;
import 'package:intl/intl.dart';

class HistorialAsesoriaPage extends StatelessWidget {
  const HistorialAsesoriaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PreferenciasUsuario _pref = new PreferenciasUsuario();
    final AsesoriaServices _asesoriaServices = new AsesoriaServices();
    return Scaffold(
      appBar: new AppBar(centerTitle: true, title: new Text('Historial de Asesorias')),
      body: FutureBuilder(
        future: _asesoriaServices.obtenerListaAsesoria(_pref.idCliente),
        builder: (BuildContext context, AsyncSnapshot<List<HistoriaAsesoriaModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null || snapshot.data.isEmpty) return helper.noData();
              // return Container();
              return _listaEventos(context, snapshot.data);
            case ConnectionState.active:
              return helper.waitingData();
            case ConnectionState.waiting:
              return helper.waitingData();
            default:
              return helper.noData();
          }
        },
      ),
    );
  }

  ListView _listaEventos(BuildContext context, List<HistoriaAsesoriaModel> eventos) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        String fecha = DateFormat('d/M/y H:ms').format(eventos[i].start);
        //final imagen = listaNumeros[indice];
        return _tarjetaDetalle(
            context: context,
            title: 'Cobro de asesoria: \$${eventos[i].cobros}',
            fecha: fecha,
            // color: eventos[i].obtenerColor(),
            color: Colors.blue);
      },
      itemCount: eventos.length,
    );
  }

  Widget _tarjetaDetalle({BuildContext context, String title, String fecha, Color color}) {
    return new Container(
        padding: EdgeInsets.all(5.0),
        margin: new EdgeInsets.only(
          top: 15.0,
          right: 20.0,
          left: 20.0,
        ),
        decoration: new BoxDecoration(
          color: color,
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
                    child: Icon(Icons.calendar_today, color: Colors.white),
                    margin: EdgeInsets.all(5.0),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: new Text(
                        fecha,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  new SizedBox(height: 5.0),
                ],
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  title,
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
