import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vuelos/vuelos_model.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/page/vuelos/DetalleVuelo.dart';
import 'package:peliculas/src/services/vuelos_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/Lista.dart';
import 'package:intl/intl.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class ListaPromociones extends StatefulWidget {
  //Constructor
  const ListaPromociones();
  @override
  _ListaPromocionesState createState() => _ListaPromocionesState();
}

class _ListaPromocionesState extends State<ListaPromociones> {
  Future<List<Promocione>> listPromociones;
  @override
  void initState() {
    super.initState();
    listPromociones = _getData();
  }

  Future<List<Promocione>> _getData() async {
    return await VuelosServices().obtenerPromociones();
  }

  @override
  Widget build(BuildContext context) {
    final String argumento = "Vuelos en Promoción";
    return Scaffold(
      appBar: appBarPaquete(context, argumento),
      body: _listado(context, argumento),
    );
  }

  Widget appBarPaquete(BuildContext context, String titulo) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      centerTitle: true,
      title: Text(titulo),
    );
  }

  Widget _listado(BuildContext context, String tipo) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
        future: listPromociones,
        builder: (BuildContext context, AsyncSnapshot<List<Promocione>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data == null || snapshot.data.isEmpty) return helper.noData();
              return _creandoElementos(context, snapshot.data);
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return helper.noData();
          }
        });
  }

  Widget _creandoElementos(BuildContext context, List<Promocione> promociones) {
    //Posiblemente esto se convierta en futureBilder

    return ListView.builder(
      itemCount: promociones.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetalleVuelo(dataPromocion: promociones[index])),
            );
          },
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),

              ///AQUI ES DONDE SE CREAN LAS IMAGENES
              Lista(
                model: new ListaModel(
                    nombre: promociones[index].nombrePromocion,
                    descripcion: promociones[index].descripcion,
                    tag1: 'Precio \$${promociones[index].precioPromocion}',
                    tag2: promociones[index].fechaDisponiblePromocion,
                    imagen: transformarFoto(promociones[index].foto),
                    fotos: promociones[index].galeria,
                    id: int.parse(promociones[index].idpromocionVuelo)),
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
      },
    );
  }

  String mensajeFecha(DateTime fecha) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    if (fecha == null) {
      return 'Siempre Disponible';
    } else {
      return 'Fecha de Salida ' + formatter.format(fecha);
    }
  }
}
