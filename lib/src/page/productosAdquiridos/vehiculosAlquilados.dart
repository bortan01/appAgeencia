import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/vehiculosAlquilados_model.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/services/vehiculo_services.dart';
import 'package:peliculas/src/widget/Lista.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class VehiculoAlquilado extends StatelessWidget {
  VehiculoAlquilado({Key key}) : super(key: key);
  final VehiculoServices _vehiculoServices = new VehiculoServices();
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
      title: Text("Vehículos Alquilados"),
    );
  }

  Widget _listado(BuildContext context) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
      future: _vehiculoServices.obtenerHistorial(),
      builder: (BuildContext context, AsyncSnapshot<VehiculosAlquiladosModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data == null || snapshot.data.historialDetalles.isEmpty) return helper.noData();
            return _creandoElementos(context, snapshot.data.historialDetalles);
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

  Widget _creandoElementos(BuildContext context, List<HistorialDetalle> autos) {
    //Posiblemente esto se convierta en futureBilder
    return ListView.builder(
        itemCount: autos.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "DetalleHistorialVehiculo", arguments: autos[index]);
              
            },
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),

                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(
                  model: new ListaModel(
                      id: int.parse(autos[index].idvehiculo),
                      nombre: '${autos[index].modelo} ${autos[index].modelo} ${autos[index].anio}',
                      descripcion: autos[index].descripcion,
                      tag1: 'Fecha de Reserva ${helper.transformarFecha(autos[index].fechaReserva)}',
                      tag2: 'Monto de Reserva \$${autos[index].monto}',
                      imagen: autos[index].foto,
                      fotos: autos[index].galeria),
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
              Navigator.pushNamed(context, "DetalleHistorialVehiculo", arguments: CourseList.list[index]);
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
