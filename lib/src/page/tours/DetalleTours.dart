import 'package:flutter/material.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/page/paquetes/CarritoCompra.dart';
import 'package:peliculas/src/widget/galeria.dart';
import 'package:provider/provider.dart';

class DetalleTours extends StatefulWidget {
  final dynamic tur;
  const DetalleTours({@required this.tur});

  @override
  _DetalleToursState createState() => _DetalleToursState();
}

class _DetalleToursState extends State<DetalleTours> {
  int pasoActual = 0;
  Future infoAdicional;

  @override
  void initState() {
    super.initState();
    infoAdicional = _getInfoAdicional();
  }

  Future<dynamic> _getInfoAdicional() async {
    return await TurServices()
        .obtenerInformacionAdicional(widget.tur['id_tours']);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TurServices>(context, listen: false);
    // final dynamic tur = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: detalle(context, widget.tur));
  }

  Widget detalle(BuildContext context, dynamic tur) {
    //Posiblemente esto se convierta en futureBilder
    return FutureBuilder(
        future: infoAdicional,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print('hecho');
              final informacionAcicional = snapshot.data;
              return scrollView(context, tur, informacionAcicional);
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
        });
  }

  Widget scrollView(
      BuildContext context, dynamic tur, dynamic informacionAdicional) {
    return CustomScrollView(
      slivers: <Widget>[
        AppBarWidget(
          titulo: tur['nombreTours'],
          imagen: transformarFoto(tur['foto']),
          id: tur['id_tours'],
        ),
        new SliverList(
            delegate: new SliverChildListDelegate([
          new SizedBox(
            height: 10.0,
          ),
          _posterTitulo(
              context: context, title: tur['nombreTours'], fecha: tur['start']),
          new SizedBox(height: 10.0),
          new Divider(
            color: Colors.grey,
            height: 20.0,
          ),
          _descripcion(tur['descripcionForApp']),
          listaHorizontal(
              titulo: "EL VIAJE INCLUYE",
              icono: Icons.check_circle,
              color: Colors.green,
              lista: tur['incluye']),
          listaHorizontal(
              titulo: "EL NO VIAJE INCLUYE",
              icono: Icons.cancel,
              color: Colors.redAccent,
              lista: tur['no_incluye']),
          listaHorizontal(
              titulo: "REQUISITOS",
              icono: Icons.report,
              color: Colors.orange,
              lista: tur['requisitos']),
          listaHorizontal(
              titulo: "LUGARES DE SALIDA",
              icono: Icons.local_car_wash,
              color: Colors.blue,
              lista: tur['lugar_salida']),
          // (tur['promociones'].length > 0)
          //     ? listaHorizontal(
          //         titulo: "Promociones",
          //         icono: Icons.golf_course,
          //         color: Colors.deepPurple,
          //         lista: tur['promociones'])
          //     : Container(),

          _crearBoton(context)
        ]))
      ],
    );
  }

  _posterTitulo(
      {@required BuildContext context,
      @required String title,
      @required String fecha}) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          new SizedBox(
            width: 20.0,
          ),
          new Flexible(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: new Text(title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget listaHorizontal(
      {@required String titulo,
      IconData icono,
      Color color,
      List<dynamic> lista}) {
    return Container(
      height: 220.0,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: new Text(
              titulo,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Flexible(
            /* Flexible : Un widget que controla cómo se flexiona un hijo de una Fila , Columna o Flex . */
            /* Iteramos la lista horizontal de los cuerpos del vehiculos */
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: lista.length,
                itemBuilder: (BuildContext context, int index) {
                  return _elementos(
                      texto: lista[index],
                      colorFondo: color,
                      icono: new Icon(icono, color: Colors.white));
                }),
          ),
        ],
      ),
    );
  }

  List<Step> listaDeElementos(dynamic informacionAdicional) {
    List<Step> myLista = [];
    informacionAdicional['sitiosTuristicos'].forEach((item) {
      myLista.add(
        new Step(
            title: new Text(item['nombre_sitio']),
            content: Column(
              children: <Widget>[
                new Text(
                  item['descripcion_sitio'],
                  textAlign: TextAlign.justify,
                ),
                Galeria(galeria: item['galeria']),
              ],
            ),
            state: StepState.complete,
            isActive: true),
      );
    });

    informacionAdicional['serviciosAdicionales'].forEach((item) {
      myLista.add(
        new Step(
            title: new Text(item['nombre_servicio']),
            content: Column(
              children: <Widget>[
                new Text(
                  item['descripcion_servicio'],
                  textAlign: TextAlign.justify,
                ),
                Galeria(
                  galeria: item['galeria'],
                ),
              ],
            ),
            state: StepState.complete,
            isActive: true),
      );
    });

    return myLista;
  }

  Widget _elementos(
      {@required String texto,
      @required Icon icono,
      @required Color colorFondo}) {
    return Opacity(
      opacity: 0.9,
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: colorFondo,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0)
            ]),
        height: 210.0,
        width: 140.0,
        child: Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(10.0),
              child: (icono),
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(40.0)),
            ),
            new SizedBox(height: 7.0),
            new Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: new Text(
                  texto,
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 6,
                ))
          ],
        ),
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: new RaisedButton.icon(
          label: new Text("Reservar Tur"),
          icon: new Icon(Icons.shopping_cart),
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).bottomAppBarColor,
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CarritoCompra(idTur: widget.tur['id_tours'])));
          }),
    );
  }

  Widget _descripcion(String descripcion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(descripcion,
              overflow: TextOverflow.ellipsis,
              maxLines: 50,
              textAlign: TextAlign.justify,
              style: AppTheme.h6Style
                  .copyWith(fontSize: 15, color: Colors.blueGrey)),
        ),
      ],
    );
  }
}
