import 'package:flutter/material.dart';
import 'package:peliculas/src/models/precios_model.dart';
import 'package:peliculas/src/page/tours/seleccionarAsiento.dart';

class CarritoCompra extends StatefulWidget {
  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  Color fondo = Colors.green;

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
                  SizedBox(height: 5.0),
                  _labelTotal(),
                  _botonContinuar()
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

  Row _botonContinuar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        FlatButton(
          child: Text("Continuar"),
          color: Colors.blueAccent,
          textColor: Colors.white,
          padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SeleccionarAsiento()));
          },
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

  Widget _labelTotal() {
    return Row(
      children: <Widget>[
        Text("Total:",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
        Spacer(),
        Text("\$33",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600))
      ],
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
        leading: CircleAvatar(
          child: Text(
            '${precioSeleccionado.cantidad.toString()}',
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        title: Text(
          '${precioSeleccionado.titulo}',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        subtitle: Text(
          'subTotal \$${(precioSeleccionado.cantidad * precioSeleccionado.pasaje).toStringAsFixed(2)}',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 13.0, color: Colors.white),
        ),
      ),
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
}
