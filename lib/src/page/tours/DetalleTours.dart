import 'package:flutter/material.dart';
import 'package:peliculas/src/models/paquete_models.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';

class DetalleTours extends StatefulWidget {
  @override
  _DetalleToursState createState() => _DetalleToursState();
}

class _DetalleToursState extends State<DetalleTours> {
  int pasoActual = 0;

  @override
  Widget build(BuildContext context) {
    final CourseModel argumento = ModalRoute.of(context).settings.arguments;
    final Paquete paquete = new Paquete();
    paquete.adult = true;
    paquete.backdropPath = argumento.imagen;
    paquete.posterPath = argumento.imagen;
    paquete.title = argumento.nombre;
    paquete.originalTitle = argumento.nombre;
    paquete.uniqueId = argumento.id.toString();

    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: CustomScrollView(
      slivers: <Widget>[
        AppBarWidget(
          titulo: paquete.title,
          imagen: argumento.imagen,
          id: paquete.uniqueId,
        ),
        new SliverList(
            delegate: new SliverChildListDelegate([
          new SizedBox(
            height: 10.0,
          ),
          _posterTitulo(paquete, context),
          new SizedBox(height: 10.0),

          listaHorizontal(
              titulo: "El viaje incluye",
              icono: Icons.add_circle,
              color: Colors.blueAccent,
              lista: ["Hotel", "Desayuno", "Transporte", "Refrigerio"]),
          _incluye(paquete, context),
          listaHorizontal(
              titulo: "El viaje no incluye",
              icono: Icons.cancel,
              color: Colors.red,
              lista: [
                "Seguros de Viaje",
                "Otros no especificados en el programa",
                "Entrada a centros turisticos",
                "Refrigerio"
              ]),
          listaHorizontal(
              titulo: "Requisitos",
              icono: Icons.report,
              color: Colors.green,
              lista: [
                "Pasaporte Vigente",
                "Vacuna contra la fiebre amarilla",
                "Dui",
              ]),

          _crearBoton(paquete, context)
          //_crearCasting(pelicula)
        ]))
      ],
    ));
  }

  _posterTitulo(Paquete paquete, BuildContext context) {
    //print(paquete.originalTitle);
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: new Image(
              image: NetworkImage(paquete.getPosterImg()),
              height: 150,
            ),
            borderRadius: new BorderRadius.circular(20.0),
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
    return Stepper(
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
    );
  }

  Widget listaHorizontal(
      {@required String titulo,
      IconData icono,
      Color color,
      List<String> lista}) {
    return Container(
      height: 140.0,
      child: Column(
        children: <Widget>[
          new Text(
            titulo,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
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
                      lista[index],
                      new Icon(
                        icono,
                        color: color,
                      ));
                }),
          ),
        ],
      ),
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
        width: 110.0,
        height: 100.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
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
