import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/itinerario_model.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class ItinerarioPage extends StatelessWidget {
  const ItinerarioPage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final String idTour = ModalRoute.of(context).settings.arguments;
    final TurServices _turServices = new TurServices();
    return Scaffold(
      appBar: new AppBar(centerTitle: true, title: new Text('Itinerario')),
      body: FutureBuilder(
        future: _turServices.obtenerItinerario(idTour),
        builder: (BuildContext context, AsyncSnapshot<ItinerarioModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null || snapshot.data.evento.isEmpty) return helper.noData();
              return _listaEventos(context, snapshot.data.evento);
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

  ListView _listaEventos(BuildContext context, List<Evento> eventos) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        //final imagen = listaNumeros[indice];
        return _tarjetaDetalle(
          context: context,
          title: eventos[i].title,
          fecha: eventos[i].obtenerFecha(),
          color: eventos[i].obtenerColor(),
        );
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
