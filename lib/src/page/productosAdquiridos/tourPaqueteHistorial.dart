import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/historialReserva_model.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/widget/Lista.dart';
import 'package:intl/intl.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class TourPaqueteHistorial extends StatelessWidget {
  TourPaqueteHistorial({Key key}) : super(key: key);
  final TurServices _turServices = new TurServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCategorias(),
      body: _listado(context),
    );
  }

  Widget appBarCategorias() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Historial de Viajes"),
    );
  }

  Widget _listado(BuildContext context) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
      future: _turServices.reservasByUser(),
      builder: (BuildContext context, AsyncSnapshot<ResponseReserva> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data.reservas == null || snapshot.data.reservas.isEmpty) return helper.noData();
            return _creandoElementos(context, snapshot.data.reservas);
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

  Widget _creandoElementos(BuildContext context, List<Reserva> infoReservas) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm a');

    //Posiblemente esto se convierta en futureBilder
    //
    return ListView.builder(
        itemCount: infoReservas.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),

                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(
                  model: new ListaModel(
                      id: int.parse(infoReservas[index].idTours),
                      nombre: infoReservas[index].nombreTours,
                      descripcion: infoReservas[index].descripcionTur,
                      tag1: 'Pago de Reserva \$${infoReservas[index].monto}',
                      tag2: 'Fecha de Reserva  ${formatter.format(infoReservas[index].fechaReserva)}',
                      imagen: '',
                      fotos: infoReservas[index].galeria),
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

  ListView listView() {
    return ListView.builder(
        itemCount: CourseList.list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "DetalleVehiculos", arguments: CourseList.list[index]);
            },
            child: Column(
              children: <Widget>[
                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(model: CourseList.list[index]),
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
