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
//        backgroundColor: Colors.blueAccent,
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
          _crearAcciones()

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
            //  overflow: TextOverflow.ellipsis,
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
    print(paquete.originalTitle);
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
                  style: Theme.of(context).textTheme.title,
                  overflow:
                      TextOverflow.ellipsis, //por si el titulo es muy grande
                ),
              ),
              new Text(paquete.originalTitle,
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis),
              new Row(
                children: <Widget>[
                  new Icon(Icons.star_border),
                  new Text(
                    "PERU",
                    style: Theme.of(context).textTheme.title,
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
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 10.0),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _elementos(
                paquete.incluye[0],
                new Icon(
                  Icons.hotel,
                  color: Colors.redAccent,
                )),
            _elementos(
                paquete.incluye[1],
                new Icon(
                  Icons.free_breakfast,
                  color: Colors.deepPurpleAccent,
                )),
            _elementos(paquete.incluye[2],
                new Icon(Icons.airport_shuttle, color: Colors.orangeAccent)),
            _elementos(
                paquete.incluye[3],
                new Icon(
                  Icons.local_dining,
                  color: Colors.green,
                )),
          ],
        ),
        new Stepper(
          currentStep: pasoActual,
          steps: listaDeElementos(paquete),
          //type: StepperType.horizontal,
          onStepContinue: () {
            setState(() {
              if (pasoActual < listaDeElementos(paquete).length - 1) {
                pasoActual++;
              }
            });
          },
        )
      ],
    );
  }

  List<Step> listaDeElementos(Paquete paquete) {
    List<Step> myLista = [
      new Step(
          title: new Text(paquete.incluye[0]),
          content: new Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
      new Step(
          title: new Text(paquete.incluye[1]),
          content: new Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          subtitle: new Text("Subtitulo"),
          isActive: true),
      new Step(
          title: new Text(paquete.incluye[2]),
          content: new Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          subtitle: new Text("Subtitulo"),
          isActive: true),
      new Step(
          title: new Text(paquete.incluye[1]),
          content: new Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          subtitle: new Text("Subtitulo"),
          isActive: true)
    ];
    return myLista;
  }

  Widget _elementos(String texto, Icon icono) {
    return Opacity(
      opacity: 0.7,
      child: new Container(
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
              textAlign: TextAlign.center,
            ))
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _accion(Icons.call, 'CALL'),
        _accion(Icons.near_me, 'ROUTE'),
        _accion(Icons.share, 'Share'),
      ],
    );
  }

  Widget _accion(IconData icon, String texto) {
    return Column(
      children: <Widget>[
        Icon(icon, color: Colors.blue, size: 40.0),
        SizedBox(height: 5.0),
        Text(
          texto,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        )
      ],
    );
  }
}