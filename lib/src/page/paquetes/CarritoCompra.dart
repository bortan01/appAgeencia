import 'package:flutter/material.dart';
import 'package:peliculas/src/models/precios_model.dart';

class CarritoCompra extends StatefulWidget {
  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  Color fondo = Colors.green;
  List<String> asientosSeleccionados = [];
  int contadorPrueba = 0;
  int pasoActual = 0;
  double screenHeight;
  Precios _precioSeleccionado;
  List<Precios> listaPrecios;
  List<Precios> asientosPrecio = [];
  int cantidadSeleccionada = 1;
  @override
  void initState() {
    super.initState();
    listaPrecios = [
      new Precios(asiento: 1, pasaje: 13.3, titulo: "asientos normal"),
      new Precios(asiento: 1, pasaje: 21.5, titulo: "Niños menores de 5 años")
    ];
    _precioSeleccionado = listaPrecios[0];
  }

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
                  _crearDropdown(),
                  _inputCantidad(),
                  _botonAgregar(),
                  crearTitulo("Mi Carrito"),
                  crearSubTitulo("(Mueva a los lados para eliminar)"),
                  SizedBox(height: 4.0),
                  _crearCarrito(),
                  crearTitulo("Elija sus Asientos"),
                  crearSubTitulo("(Asientos color verde)"),
                  SizedBox(height: 4.0),
                  _crearBus(
                      context: context,
                      asientosDerecho: 3,
                      asientosIzquierdos: 3,
                      filas: 3),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text("Continuar"),
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

  Widget _inputCantidad() {
    return TextFormField(
      initialValue: "1",
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'ingrese numero de asientos'),
      onChanged: (String valor) {
        cantidadSeleccionada = int.parse(valor);
      },
    );
  }

  Widget _botonAgregar() {
    return RaisedButton(
      child: Container(
          width: double.infinity,
          child: Text(
            "Agregar a mi carrito",
            textAlign: TextAlign.center,
          )),
      color: Colors.blue,
      textColor: Colors.white,
      focusColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        setState(() {
          agregarACarrito();
        });
      },
    );
  }

  void agregarACarrito() {
    final encontrado =
        asientosPrecio.indexWhere((pre) => pre.id == _precioSeleccionado.id);
    if (encontrado == -1) {
      _precioSeleccionado.cantidad = cantidadSeleccionada;
      asientosPrecio.add(_precioSeleccionado);
    } else {
      asientosPrecio.forEach((element) {
        if (element.id == _precioSeleccionado.id) {
          element.cantidad = cantidadSeleccionada;
          return;
        }
      });
    }
  }

  void eliminarCarrito(id) {
    asientosPrecio.removeWhere((element) => element.id == id);
  }

  Widget _crearDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          crearTitulo("Seleccione el tipo de asiento"),
          SizedBox(
            height: 3.0,
          ),
          DropdownButtonFormField(
              isExpanded: true,
              decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)))),
              icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
              value: listaPrecios[0],
              items: opcionesDropdown(),
              onChanged: (opt) {
                print(opt);
                setState(() {
                  _precioSeleccionado = opt;
                });
              }),
        ],
      ),
    );
  }

  Text crearTitulo(String tiulo) {
    return Text(
      tiulo,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }

  Text crearSubTitulo(String tiulo) {
    return Text(
      tiulo,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
    );
  }

  Widget _crearCarrito() {
    List<Widget> listaIttem = [];
    asientosPrecio.forEach((element) {
      listaIttem.add(_crearItemCarrito(element));
    });
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: listaIttem,
      ),
    );
  }

  Widget _crearItemCarrito(Precios precioSeleccionado) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        eliminarCarrito(precioSeleccionado.id);
      },
      background: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
      ),
      child: ListTile(
        title: Text(
          '${precioSeleccionado.cantidad.toString()} ${precioSeleccionado.titulo} (\$${precioSeleccionado.pasaje.toString()} c/u)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        subtitle: Text(
          'subTotal \$${(precioSeleccionado.cantidad * precioSeleccionado.pasaje).toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _crearBus(
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
          fondoActivo: Colors.green,
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
          fondoActivo: Colors.green,
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
        fondoActivo: Colors.green,
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

  List<DropdownMenuItem<Precios>> opcionesDropdown() {
    List<DropdownMenuItem<Precios>> lista = new List();
    listaPrecios.forEach((precioItem) {
      lista.add(DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Text(
                '${precioItem.titulo} \$${precioItem.pasaje.toString()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          value: precioItem));
    });
    return lista;
  }

  void agregarAsiento(String identificadorAsiento) {
    asientosSeleccionados.add(identificadorAsiento);
    print(asientosSeleccionados.toString());
  }

  void eliminarAsiento(String identificadorAsiento) {
    asientosSeleccionados.remove(identificadorAsiento);
    print(asientosSeleccionados.toString());
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
    print("dibuejando asientos");
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
