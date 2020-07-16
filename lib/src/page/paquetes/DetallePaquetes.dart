import 'package:flutter/material.dart';
import 'package:peliculas/src/models/paquete_models.dart';
//import 'package:peliculas/src/providers/peliculas_provider.dart';

class DetallePaquetes extends StatefulWidget {
  @override
  _DetallePaquetesState createState() => _DetallePaquetesState();
}

class _DetallePaquetesState extends State<DetallePaquetes> {
  int pasoActual = 0;

  @override
  Widget build(BuildContext context) {
    final Paquete paquete = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(paquete),
        new SliverList(
            delegate: new SliverChildListDelegate([
          new SizedBox(
            height: 10.0,
          ),
          _posterTitulo(paquete, context),
          new SizedBox(height: 10.0),

          _incluye(paquete, context),
          _noIncluye(paquete, context),
          _requisitos(paquete, context),
          _crearBoton(paquete, context)
          //_crearCasting(pelicula)
        ]))
      ],
    ));
  }

  Widget _crearAppbar(Paquete paquete) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black54,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Text(
            paquete.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(paquete.getBackgroudImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150000),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitulo(Paquete paquete, BuildContext context) {
    //print(paquete.originalTitle);
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            child: ClipRRect(
              child: new Image(
                image: NetworkImage(paquete.getPosterImg()),
                height: 150,
              ),
              borderRadius: new BorderRadius.circular(20.0),
            ),
            tag: paquete.uniqueId,
          ),
          new SizedBox(
            width: 20.0,
          ),
          new Flexible(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: new Text(
                  paquete.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow:
                      TextOverflow.ellipsis, //por si el titulo es muy grande
                ),
              ),
              new Text(paquete.originalTitle,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis),
              new Row(
                children: <Widget>[
                  new Icon(Icons.attach_money),
                  new Text(
                    "695.00",
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _incluye(Paquete paquete, BuildContext context) {
    return Column(
      children: <Widget>[
        new Text(
          "El viaje Incluye",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 10.0),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _elementos(
                "Hotel",
                new Icon(
                  Icons.hotel,
                  color: Colors.blueAccent,
                )),
            _elementos(
                "Desayuno",
                new Icon(
                  Icons.free_breakfast,
                  color: Colors.blueAccent,
                )),
            _elementos("Transporte",
                new Icon(Icons.airport_shuttle, color: Colors.blueAccent)),
            _elementos(
                "Refrigerio",
                new Icon(
                  Icons.local_dining,
                  color: Colors.blueAccent,
                )),
          ],
        ),
        new Stepper(
          currentStep: pasoActual,
          physics:
              new ClampingScrollPhysics(), //SE DEBE DE AGREGAR ESTA PROPIEDAD PARA EVITAR QUE CREE UN NUEVO SCROLL
          steps: listaDeElementos(paquete),
          onStepContinue: () {
            setState(() {
              if (pasoActual < listaDeElementos(paquete).length - 1) {
                pasoActual++;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (pasoActual > 0) {
                pasoActual--;
              }
            });
          },
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                FlatButton(
                  onPressed: onStepContinue,
                  color: (Theme.of(context).accentColor),
                  child: const Text(
                    'SIGUIENTE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                FlatButton(
                  onPressed: onStepCancel,
                  color: (Theme.of(context).accentColor),
                  child: const Text(
                    'ATRAS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget _noIncluye(Paquete paquete, BuildContext context) {
    return Column(
      children: <Widget>[
        new Text(
          "El viaje no incluye",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 10.0),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _elementos(
                "Seguros de Viaje",
                new Icon(
                  Icons.cancel,
                  color: Colors.red,
                )),
            _elementos(
                "Ni otros no especificados en el programa",
                new Icon(
                  Icons.cancel,
                  color: Colors.red,
                )),
            _elementos(
                "Entrada a centros turisticos",
                new Icon(
                  Icons.cancel,
                  color: Colors.red,
                )),
          ],
        ),
      ],
    );
  }

  List<Step> listaDeElementos(Paquete paquete) {
    List<Step> myLista = [
      new Step(
          title: new Text("Hotel"),
          content: Column(
            children: <Widget>[
              new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  // height: especioDisponible,
                  image: AssetImage(
                    "assets/img/hotel.jpg",
                  )),
              new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            ],
          ),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
      new Step(
          title: new Text("Desayuno"),
          content: Column(
            children: <Widget>[
              new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  // height: especioDisponible,
                  image: AssetImage(
                    "assets/img/desayunos.jpg",
                  )),
              new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            ],
          ),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
      new Step(
          title: new Text("Transporte"),
          content: Column(
            children: <Widget>[
              new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  // height: especioDisponible,
                  image: AssetImage(
                    "assets/img/camioneta.png",
                  )),
              new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            ],
          ),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
      new Step(
          title: new Text("Refrigerio"),
          content: Column(
            children: <Widget>[
              new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  // height: especioDisponible,
                  image: AssetImage(
                    "assets/img/refrigerio.jpg",
                  )),
              new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            ],
          ),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
    ];
    return myLista;
  }

  Widget _elementos(String texto, Icon icono) {
    return Opacity(
      opacity: 0.7,
      child: new Container(
        width: 100.0,
        height: 100.0,
        child: Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(8.0),
              child: (icono),
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(40.0)),
            ),
            new SizedBox(height: 7.0),
            new Container(
                child: new Text(
              texto,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 3,
            ))
          ],
        ),
      ),
    );
  }

  Widget _requisitos(Paquete paquete, BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 15.0),
        new Text(
          "Requisitos",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 10.0),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _elementos(
                "Pasaporte Vigente",
                new Icon(
                  Icons.report,
                  color: Colors.green,
                )),
            _elementos(
                "Vacuna contra la fiebre amarilla",
                new Icon(
                  Icons.report,
                  color: Colors.green,
                )),
          ],
        ),
      ],
    );
  }

  Widget _crearBoton(Paquete paquete, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: new RaisedButton.icon(
          label: new Text("Añadir a carrito"),
          icon: new Icon(Icons.shopping_cart),
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).bottomAppBarColor,
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.pushNamed(context, 'CarritoCompra', arguments: paquete);
          }),
    );
  }
}
