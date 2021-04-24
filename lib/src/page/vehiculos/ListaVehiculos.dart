import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/categoria_model.dart';
import 'package:peliculas/src/models/vehiculo/vehiculo_model.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/page/vehiculos/DetalleVehiculos.dart';
import 'package:peliculas/src/services/vehiculo_services.dart';
import 'package:peliculas/src/widget/Lista.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class ListaVehiculos extends StatelessWidget {
  ListaVehiculos({Key key}) : super(key: key);
  final VehiculoServices _vehiculoServices = new VehiculoServices();
  @override
  Widget build(BuildContext context) {
    final Categoria categoria = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: appBarCategorias(categoria.nombreCategoria),
      body: _listado(context, categoria),
    );
  }

  Widget appBarCategorias(String argumento) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Categoría: " + argumento),
    );
  }

  Widget _listado(BuildContext context, Categoria categoria) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
      future: _vehiculoServices.obtenerVehiculos(categoria.idcategoria.toString()),
      builder: (BuildContext context, AsyncSnapshot<VehiculosModel> snapshot) {
        VehiculosModel data = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
             if (data == null || data.autos.isEmpty) return helper.noData();
            return _creandoElementos(context, data);
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

  Widget _creandoElementos(BuildContext context, VehiculosModel data) {
    //Posiblemente esto se convierta en futureBilder
    List<Auto> autos = data.autos;
    return ListView.builder(
        itemCount: autos.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetalleVehiculos(autos[index], data.opcionesAdicionales)));
            },
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),

                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                Lista(
                  model: new ListaModel(
                      id: int.parse(autos[index].idvehiculo),
                      nombre: '${autos[index].marca} ${autos[index].modelo} ${autos[index].anio}',
                      descripcion: autos[index].descripcion,
                      tag1: 'Precio Diario \$${autos[index].precioDiario}',
                      tag2: autos[index].transmision,
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
