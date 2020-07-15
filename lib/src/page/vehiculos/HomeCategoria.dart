import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:peliculas/src/page/vehiculos/HomeVehiculos.dart';

class HomeCategoria extends StatefulWidget {
  @override
  _PagelistaVehiculostate createState() => _PagelistaVehiculostate();
}

class _PagelistaVehiculostate extends State<HomeCategoria> {
  int posicionVehiculo = 0;
  List listaVehiculos;
  BoxDecoration boxDecorationFondo;

  Color colorCardView = Colors.white12;
  Color colorCardViewHorizontal = Colors.white10;

  AnimationController animateController;
  AnimationController animateController2;

  @override
  void dispose() {
    animateController.dispose();
    animateController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    boxDecorationFondo = Theme.of(context).brightness == Brightness.dark
        ? BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).canvasColor,
              Theme.of(context).canvasColor
            ],
          ))
        : BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(253, 254, 254, 1.0),
              Color.fromRGBO(214, 234, 248, 1.0)
            ],
          ));
    listaVehiculos = [
      {
        'titulo': "Sedan",
        'subtitulo':
            "Una característica clave en un sedán es la seguridad que aporta. Los frenos antibloqueo son la primera línea de defensa ante cualquier accidente. Al momento de la colisión, las bolsas de aire pueden salvar la vida de tus pasajeros.",
        'assetImage': AssetImage("assets/img/sedan1.png"),
        'superficie': 'Auto Familiar',
        'distancia': '0 km',
      },
      {
        'titulo': "Camionetas",
        'subtitulo':
            "Empleado generalmente para el transporte de mercancías, un término que hoy en día se aplica a veces informalmente a distintos tipos de automóviles, en concreto pickups, vehículos todoterreno, furgonetas, monovolúmenes, y familiares.",
        'assetImage': AssetImage("assets/img/camioneta.png"),
        'superficie': '74,8 millones km²',
        'distancia': ' 57,91 millones km',
      },
      {
        'titulo': "Pickup",
        'subtitulo':
            "Empleado generalmente para el transporte de mercancías, y que tiene en su parte trasera una zona de carga descubierta (denominada caja, batea, balde, carrocería, platón, cama o palangana), en la cual se pueden colocar objetos grandes.",
        'assetImage': AssetImage("assets/img/pickup.png"),
        'superficie': '460,2 millones km²',
        'distancia': '108,2 millones km',
      },
      {
        'titulo': "Microbus",
        'subtitulo':
            "Gran furgoneta que tiene asientos en la parte posterior para los pasajeros y ventanas a los lados.",
        'assetImage': AssetImage("assets/img/1.png"),
        'superficie': '510,1 millones km²',
        'distancia': '149,6 millones km',
      },
      {
        'titulo': "Minivans",
        'subtitulo':
            "Ofrece características aptas para la familia, además de toda la tecnología que se podría desear en un paquete atractivo y a un precio muy conveniente.",
        'assetImage': AssetImage("assets/img/1.png"),
        'superficie': '144,8 millones km²',
        'distancia': '227,9 millones km',
      },
    ];

    return Container(
      decoration: boxDecorationFondo,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              appBarCategorias(),
              vehiculosPopulares(),
              cardViewAutoView(
                //color: colorCardView,
                colortexto: Theme.of(context).bottomAppBarColor,
                assetImage: listaVehiculos[posicionVehiculo]["assetImage"],
                titulo: listaVehiculos[posicionVehiculo]["titulo"],
                subtitulo: listaVehiculos[posicionVehiculo]["subtitulo"],
                distancia: listaVehiculos[posicionVehiculo]["distancia"],
                superficie: listaVehiculos[posicionVehiculo]["superficie"],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeVehiculos()),
            );
            // Add your onPressed code here!
          },
          label: Text('Ver autos'),
          icon: Icon(Icons.check),
        ),
      ),
    );
  }

  Widget vehiculosPopulares() {
    return SizedBox(
      height: 100.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            /* Flexible : Un widget que controla cómo se flexiona un hijo de una Fila , Columna o Flex . */
            /* Iteramos la lista horizontal de los cuerpos del vehiculos */
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listaVehiculos.length,
                itemBuilder: (BuildContext context, int index) {
                  return cardViewAutoHorizontal(
                    color: colorCardViewHorizontal,
                    colortexto: Theme.of(context).bottomAppBarColor,
                    index: index,
                    assetImage: listaVehiculos[index]["assetImage"],
                    titulo: listaVehiculos[index]["titulo"],
                    subtitulo: listaVehiculos[index]["subtitulo"],
                    distancia: listaVehiculos[index]["distancia"],
                    superficie: listaVehiculos[index]["superficie"],
                  );
                }),
          ),
        ],
      ),
    );
  }

  /* Devuelve una cardview */
  Widget cardViewAutoHorizontal({
    @required int index,
    @required AssetImage assetImage,
    @required String titulo,
    String subtitulo = "",
    String distancia = "",
    String superficie = "",
    Color color = Colors.white10,
    Color colortexto = Colors.white10,
  }) {
    /* Imagen */
    final imagenVehiculo = new Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Image(
        image: assetImage,
        height: 75.0,
        width: 75.0,
        fit: BoxFit.cover,
      ),
    );
    /* Tarjeta con detalles */
    final tarjetaDetalles = Container(
        width: 250,
        height: 100.0,
        margin: new EdgeInsets.only(left: 30.0),
        /* margen Tarjeta */
        decoration: new BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 8.0))
          ], /* Aplica sombra */
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              animateController.repeat();
              animateController2.repeat();
              posicionVehiculo = index;
            });
          },
          borderRadius: new BorderRadius.circular(8.0),
          child: Container(
            margin: const EdgeInsets.only(
                left: 55.0, top: 12.0, right: 12.0, bottom: 12.0),
            /*  Margen del contenido dentro de la tarjeta  */
            constraints: new BoxConstraints.expand(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(titulo,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: colortexto),
                    overflow: TextOverflow.ellipsis),
                new Text(subtitulo,
                    style: TextStyle(fontSize: 12.0, color: colortexto),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ));
    /* Creamos una vista superpuesta  */
    return Container(
        margin: const EdgeInsets.all(12.0),
        child: Stack(
          children: <Widget>[
            tarjetaDetalles,
            imagenVehiculo,
          ],
        ));
  }

  /* Devuelve una vista previa de un tarjeta grande con los datos del planeta enfocado */
  Widget cardViewAutoView({
    @required AssetImage assetImage,
    @required String titulo,
    String subtitulo = "",
    String distancia = "",
    String superficie = "",
    Color color = Colors.white10,
    Color colortexto = Colors.white10,
  }) {
    double width = MediaQuery.of(context).size.width;
    /* Imagen */
    final imagenVehiculo = new Container(
      margin: EdgeInsets.only(left: width * 0.27),
      alignment: FractionalOffset.centerLeft,
      child: ElasticInDown(
        /* ElasticInDown : animación */
        manualTrigger: true,
        /* (opcional) si es verdadero, no disparará la animación al cargar */
        controller: (controller) => animateController = controller,
        /* (opcional, pero obligatorio si usa manualTrigger: true) Esta devolución de llamada expone el AnimationController utilizado para la animación seleccionada. Luego puede llamar a animationController.forward () para activar la animación donde quiera manualmente. */
        child: SpinPerfect(
          /* SpinPerfect : animación */
          manualTrigger: true,
          /* (opcional) si es verdadero, no disparará la animación al cargar */
          controller: (controller) => animateController2 = controller,
          /* (opcional, pero obligatorio si usa manualTrigger: true) Esta devolución de llamada expone el AnimationController utilizado para la animación seleccionada. Luego puede llamar a animationController.forward () para activar la animación donde quiera manualmente. */
          child: Image(image: assetImage, height: 150.0, width: 150.0),
          infinite: true,
          animate: true,
        ),
      ),
    );
    /* Tarjeta con detalles */
    final tarjetaDetalles = new Container(
        width: width,
        height: 300.0,
        /* Margen de la tarjeta */
        margin: new EdgeInsets.only(top: 35.0),
        decoration: new BoxDecoration(
          color: Color(0xFF4B9DFE),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 8.0))
          ], /* Aplica sombra */
        ),
        child: Container(
          /* Margen del contenido */
          margin: const EdgeInsets.only(
              left: 12.0, top: 75.0, right: 12.0, bottom: 12.0),
          constraints: new BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(titulo,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: colortexto),
                  overflow: TextOverflow.ellipsis),
              new SizedBox(height: 5.0),
              new Text(subtitulo,
                  style: TextStyle(fontSize: 14.0, color: colortexto),
                  textAlign: TextAlign.center),
              new Divider(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.brightness_7, size: 14.0, color: Colors.amber),
                  new SizedBox(width: 5.0),
                  new Text(distancia,
                      style: TextStyle(fontSize: 12.0, color: colortexto),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              new SizedBox(height: 5.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.transfer_within_a_station,
                      size: 14.0, color: Colors.blueAccent),
                  new SizedBox(width: 5.0),
                  new Text(superficie,
                      style: TextStyle(fontSize: 12.0, color: colortexto),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ],
          ),
        ));
    /* Creamos una vista superpuesta  */
    return Container(
        margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: new Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            tarjetaDetalles,
            imagenVehiculo,
          ],
        ));
  }

  Widget appBarCategorias() {
    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        );
      }),
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: Text("Categoría de Vehiculos"),
    );
  }
}
