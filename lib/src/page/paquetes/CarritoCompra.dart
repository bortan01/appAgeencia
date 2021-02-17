import 'package:flutter/material.dart';
import 'package:peliculas/src/models/paquete_models.dart';
//import 'package:peliculas/src/providers/peliculas_provider.dart';

class CarritoCompra extends StatefulWidget {
  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  Color fondo = Colors.green;
  int pasoActual = 0;
  String _valueNinos = '0';
  String _valueAdultos = '0';
  String _valueAncianos = '0';
  double screenHeight;
  // int filas;
  // int asiento_derecho;
  // int asiento_izquierdo;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    //final lista = listaInventada();
    return Scaffold(
      appBar: appBarCarrito(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            paginaFondo(),
            imagenPortada(context),
            cajaFormulario(context),
          ],
        ),
      ),
    );
  }

  Widget appBarCarrito() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Carrito de Compras"),
    );
  }

  Widget paginaFondo() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "",
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget cajaFormulario(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _crearBus(
                      context: context,
                      asientosDerecho: 3,
                      asientosIzquierdos: 3,
                      filas: 4),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Rellene los siguientes Campos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _inputNino(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputAdulto(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputAnciano(),
                  SizedBox(
                    height: 20,
                  ),
                  _totalPagp(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text("Reservar"),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Puede completar datos adicionales en Pagina Web",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

  Widget imagenPortada(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/img/portada.png',
        fit: BoxFit.cover,
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
                    "assets/img/transporte.jpg",
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

  Widget _inputNino() {
    return new TextField(
      // autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Personas menores de 12 años',
          labelText: 'Niños',
          helperText: 'Debes digitar una cantidad valida',
          suffixIcon: Icon(Icons.playlist_add_check)),

      onChanged: (String valor) {
        _valueNinos = valor;
        setState(() {});
      },
    );
  }

  Widget _inputAdulto() {
    return new TextField(
      // autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Mayores de 12 años menores de 60',
          labelText: 'Adultos',
          helperText: 'Debes digitar una cantidad valida',
          suffixIcon: Icon(Icons.playlist_add_check)),

      onChanged: (String valor) {
        _valueAdultos = valor;
        setState(() {});
      },
    );
  }

  Widget _inputAnciano() {
    return new TextField(
      // autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Mayores de 60',
          labelText: 'Tercera edad',
          helperText: 'Debes digitar una cantidad valida',
          suffixIcon: Icon(Icons.playlist_add_check)),

      onChanged: (String valor) {
        _valueAncianos = valor;
        setState(() {});
      },
    );
  }

  Widget _crearBoton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: new RaisedButton.icon(
          label: new Text("Reservar"),
          icon: new Icon(Icons.payment),
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).bottomAppBarColor,
          shape: StadiumBorder(),
          onPressed: () {}),
    );
  }

  Widget _totalPagp() {
    return new Container(
      height: 90.0,
      //margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Descripcion",
                  style: TextStyle(color: Theme.of(context).bottomAppBarColor)),
              Text("Total",
                  style: TextStyle(color: Theme.of(context).bottomAppBarColor)),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("2x Machupichu (Adulto)",
                  style: TextStyle(
                    color: Theme.of(context).bottomAppBarColor,
                  )),
              Text('€200',
                  style: TextStyle(color: Theme.of(context).bottomAppBarColor)),
            ],
          )
        ],
      ),
    );
  }

  _crearBus(
      {@required BuildContext context,
      @required int asientosIzquierdos,
      @required asientosDerecho,
      @required filas}) {
    int totalAsientos = asientosIzquierdos + asientosDerecho + 1;
    final scrimSize = MediaQuery.of(context).size;
    final dimensiones = ((scrimSize.width * 0.85) - 88) / totalAsientos;
    List<Row> listaFilas = [];
    //con labelAsiento sele ira colocando el numero que apparece dentro de los cuadros
    int labelAsiento = 1;
    //se va a hacer una vuelta por cada fila
    for (var i = 1; i <= filas; i++) {
      List<Widget> elementos = [];
      //este es para dibujar los asientos izquierdos
      for (var j = 1; j <= asientosIzquierdos; j++) {
        elementos.add(Asiento(
            context: context,
            label: labelAsiento.toString(),
            identificador: '${i.toString()}_${j.toString()}',
            fondoActivo: Colors.blue,
            fondoInactivo: Colors.red,
            dimensiones: dimensiones));
        labelAsiento++;
      }
      //este es para dibujar la columna que separa los derechos de los izquierdos
      elementos.add(Asiento(
          context: context,
          label: "",
          identificador:
              '${i.toString()}_${(asientosIzquierdos + 1).toString()}',
          fondoActivo: Colors.white,
          fondoInactivo: Colors.white,
          dimensiones: dimensiones));
      //este es para dibujar los asidento derechos
      for (var j = 2 + asientosIzquierdos;
          j <= asientosDerecho + asientosIzquierdos + 1;
          j++) {
        elementos.add(Asiento(
            context: context,
            label: labelAsiento.toString(),
            identificador: '${i.toString()}_${j.toString()}',
            fondoActivo: Colors.blue,
            fondoInactivo: Colors.red,
            dimensiones: dimensiones));
        labelAsiento++;
      }

      listaFilas.add(Row(
          mainAxisAlignment: MainAxisAlignment.center, children: elementos));
    }
    return Column(children: listaFilas);
  }
}

class Asiento extends StatefulWidget {
  const Asiento({
    Key key,
    @required this.context,
    @required this.label,
    @required this.fondoActivo,
    @required this.identificador,
    @required this.fondoInactivo,
    @required this.dimensiones,
  }) : super(key: key);

  final BuildContext context;
  final String label;
  final String identificador;
  final Color fondoActivo;
  final Color fondoInactivo;
  final double dimensiones;

  @override
  _AsientoState createState() => _AsientoState();
}

class _AsientoState extends State<Asiento> {
  bool select = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print(widget.identificador);
            setState(() {
              select = !select;
            });
            // return null;
          },
          child: Container(
            margin: EdgeInsets.all(2.0),
            height: widget.dimensiones,
            width: widget.dimensiones,
            child: Container(
                decoration: BoxDecoration(
                    color: select ? widget.fondoActivo : widget.fondoInactivo,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                padding: EdgeInsets.only(top: widget.dimensiones / 3.5),
                child: Text(
                  widget.label,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      ],
    );
  }
}
