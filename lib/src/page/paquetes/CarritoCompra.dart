import 'package:flutter/material.dart';
import 'package:peliculas/src/models/paquete_models.dart';
//import 'package:peliculas/src/providers/peliculas_provider.dart';

class CarritoCompra extends StatefulWidget {
  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  Color fondo = Colors.green;
  List<String> asientosSeleccionados = [];
  int contadorPrueba = 0;
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

  void agregarAsiento(String identificadorAsiento) {
    asientosSeleccionados.add(identificadorAsiento);
    print(asientosSeleccionados.toString());
  }

  void eliminarAsiento(String identificadorAsiento) {
    asientosSeleccionados.remove(identificadorAsiento);
    print(asientosSeleccionados.toString());
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
                  SizedBox(height: 15),
                  _inputNino(),
                  SizedBox(height: 20),
                  _inputAdulto(),
                  SizedBox(height: 20),
                  _inputAnciano(),
                  SizedBox(height: 20),
                  _totalPagp(),
                  SizedBox(height: 20),
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

  // Widget _crearBoton() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //     child: new RaisedButton.icon(
  //         label: new Text("Reservar"),
  //         icon: new Icon(Icons.payment),
  //         color: Theme.of(context).accentColor,
  //         textColor: Theme.of(context).bottomAppBarColor,
  //         shape: StadiumBorder(),
  //         onPressed: () {}),
  //   );
  // }

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
    final int totalAsientos = asientosIzquierdos + asientosDerecho + 1;
    final scrimSize = MediaQuery.of(context).size;
    final dimensiones = ((scrimSize.width * 0.85) - 88) / totalAsientos;
    final List<String> asientosDeshabilitados = "1_1,11_6".split(",");
    final List<String> ocupados = ["1_11", "4_7"];
    final List<String> asientosNoDisponibles =
        new List.from(asientosDeshabilitados)..addAll(ocupados);

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
          dimensiones: dimensiones,
          asientosNoDisponibles: asientosNoDisponibles,
          agregar: agregarAsiento,
          eliminar: eliminarAsiento,
        ));
        labelAsiento++;
      }
      //Agregamos una separacion entre los asientos derechos y izquierdos
      elementos.add(Container(width: dimensiones, height: dimensiones));
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
          asientosNoDisponibles: asientosNoDisponibles,
          agregar: agregarAsiento,
          dimensiones: dimensiones,
          eliminar: eliminarAsiento,
        ));
        labelAsiento++;
      }
      //para agregar la fila trasera

      listaFilas.add(Row(
          mainAxisAlignment: MainAxisAlignment.center, children: elementos));
    }
    final espacio = Row(
      children: <Widget>[SizedBox(width: 20.0, height: 20.0)],
    );
    final List<Widget> otraFila = [];
    for (var i = 1; i <= asientosDerecho + asientosIzquierdos + 1; i++) {
      otraFila.add(Asiento(
        context: context,
        label: labelAsiento.toString(),
        identificador: '${(filas + 2).toString()}_${i.toString()}',
        fondoActivo: Colors.blue,
        fondoInactivo: Colors.red,
        asientosNoDisponibles: asientosNoDisponibles,
        agregar: agregarAsiento,
        dimensiones: dimensiones,
        eliminar: eliminarAsiento,
      ));
      labelAsiento++;
    }
    listaFilas.add(espacio);
    listaFilas.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center, children: otraFila));
    return Column(
      children: listaFilas,
    );
  }
}

class Asiento extends StatefulWidget {
  const Asiento(
      {Key key,
      @required this.context,
      @required this.label,
      @required this.fondoActivo,
      @required this.identificador,
      @required this.fondoInactivo,
      @required this.dimensiones,
      @required this.agregar,
      @required this.eliminar,
      @required this.asientosNoDisponibles})
      : super(key: key);

  final BuildContext context;
  final String label;
  final String identificador;
  final Color fondoActivo;
  final Color fondoInactivo;
  final double dimensiones;
  final Function agregar;
  final Function eliminar;
  final List<String> asientosNoDisponibles;

  @override
  _AsientoState createState() => _AsientoState();
}

class _AsientoState extends State<Asiento> {
  bool select = true;
  bool deshabilitado = false;

  @override
  Widget build(BuildContext context) {
    //verificamos si el elemento identificador que recibimos existe en la lista
    //de los asientos que ya han sido ocupados o estan hinabilitados
    //y ocupamos el sentinela deshabilitado para manejarlo
    widget.asientosNoDisponibles.forEach((element) {
      if (widget.identificador == element) {
        deshabilitado = true;
        return;
      }
    });
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (!deshabilitado) {
              setState(() {
                if (select) {
                  widget.agregar(widget.identificador);
                } else {
                  widget.eliminar(widget.identificador);
                }
                select = !select;
              });
            }
            // return null;
          },
          child: Container(
            margin: EdgeInsets.all(2.0),
            height: widget.dimensiones,
            width: widget.dimensiones,
            child: Container(
                decoration: BoxDecoration(
                    //se verifica si el asiento esta deshabilitado
                    color: !deshabilitado
                        //sii esta habilitado se le coloca el color activo
                        ? select ? widget.fondoActivo : widget.fondoInactivo
                        //de lo contrario se le coloca un color negro
                        : Colors.black,
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
