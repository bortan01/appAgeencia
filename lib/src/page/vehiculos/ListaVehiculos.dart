import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/vehiculo_model.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/services/vehiculo_services.dart';
import 'package:peliculas/src/widget/Lista.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class ListaVehiculos extends StatelessWidget {
  ListaVehiculos({Key key}) : super(key: key);
  final VehiculoServices _vehiculoServices = new VehiculoServices();
  @override
  Widget build(BuildContext context) {
    final String argumento = ModalRoute.of(context).settings.arguments;
    return Scaffold(appBar: appBarCategorias(argumento), body: _listado(context));
  }

  Widget appBarCategorias(String argumento) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Categoría: " + argumento),
    );
  }

  Widget _listado(BuildContext context) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
      future: _vehiculoServices.obtenerVehiculos(),
      builder: (BuildContext context, AsyncSnapshot<List<Auto>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data == null) return helper.noData();
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
      },
    );
  }

  Widget _creandoElementos(BuildContext context, List<Auto> data) {
    //Posiblemente esto se convierta en futureBilder

    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "DetalleVehiculos", arguments: data[index]);
            },
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),

                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(
                  model: new ListaModel(
                      id: int.parse(data[index].idvehiculo),
                      nombre: '${data[index].marca} ${data[index].modelo} ${data[index].anio}',
                      descripcion: data[index].descripcion,
                      tag1: 'Precio Diario \$${data[index].precioDiario}',
                      tag2: data[index].transmision,
                      imagen: data[index].foto,
                      fotos: data[index].galeria),
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
