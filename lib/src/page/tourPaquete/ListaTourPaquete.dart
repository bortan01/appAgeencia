import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/DataTourPaquete_model.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/page/tourPaquete/DetallePaquetes.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/Lista.dart';
import 'package:intl/intl.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class ListaTours extends StatefulWidget {
  final String tipo;
  //Constructor
  const ListaTours({@required this.tipo});
  @override
  _ListaToursState createState() => _ListaToursState();
}

class _ListaToursState extends State<ListaTours> {
  Future<List<DataTourPaqueteModel>> listTourPaquete;
  @override
  void initState() {
    super.initState();
    listTourPaquete = _getData();
  }

  Future<List<DataTourPaqueteModel>> _getData() async {
    return await TurServices().obtenerDataTourPaquete(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    final String argumento = widget.tipo;
    return Scaffold(
      appBar: appBarPaquete(context, "Tours " + argumento),
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
        future: listTourPaquete,
        builder: (BuildContext context, AsyncSnapshot<List<DataTourPaqueteModel>> snapshot) {
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

  Widget _creandoElementos(BuildContext context, List<DataTourPaqueteModel> listTourPaquete) {
    //Posiblemente esto se convierta en futureBilder

    return ListView.builder(
      itemCount: listTourPaquete.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // if (listTourPaquete[index].tipo == 'Paquete Nacional' ||
            //     listTourPaquete[index].tipo == 'Paquete Internacional')
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetallePaquete(dataTourPaquete: listTourPaquete[index])),
            );
            // else
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => DetalleTours(tourPaquete: myTourPaquete)),
            //   );
          },
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),

              ///AQUI ES DONDE SE CREAN LAS IMAGENES
              Lista(
                model: new ListaModel(
                    nombre: listTourPaquete[index].nombreTours,
                    descripcion: listTourPaquete[index].descripcionForApp,
                    tag1: 'Precio \$${listTourPaquete[index].precio.toString()}',
                    tag2: mensajeFecha(listTourPaquete[index].start),
                    imagen: transformarFoto(listTourPaquete[index].foto),
                    fotos: listTourPaquete[index].galeria,
                    id: int.parse(listTourPaquete[index].idTours)),
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
