import 'package:flutter/material.dart';
import 'package:peliculas/src/models/precios_model.dart';
import 'package:peliculas/src/models/tourPaquete/InfoReserva_model.dart';
import 'package:peliculas/src/models/tourPaquete/TourPaquete_model.dart';
import 'package:peliculas/src/models/tourPaquete/Wompi_model.dart';
import 'package:peliculas/src/models/tourPaquete/detalleTur_model.dart';
import 'package:peliculas/src/models/tourPaquete/transporte_model.dart';
import 'package:peliculas/src/page/tourPaquete/SeleccionarAsiento.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class CarritoCompra extends StatefulWidget {
  final TourPaqueteModel tourPaqueteModel;

  const CarritoCompra({Key key, @required this.tourPaqueteModel}) : super(key: key);
  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  Future<InfoReservaModel> futureInfoReserva;
  Color fondo = Colors.green;
  double screenHeight;
  Precios _precioSeleccionado;
  List<Precios> listaPrecios = [];
  List<Precios> asientosPrecio = [];
  int cantidadSeleccionada = 1;
  double total = 0.0;
  TransporteModel transporte;
  InfoReservaModel infoReservaModel;
  bool creandoEnlace = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureInfoReserva = _getInfoReserva();
  }

  Future<InfoReservaModel> _getInfoReserva() async {
    return await TurServices().obtenerInfomacionToReserva(widget.tourPaqueteModel.idTours.toString());
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarCarrito(),
      body: FutureBuilder(
          future: futureInfoReserva,
          builder: (BuildContext context, AsyncSnapshot<InfoReservaModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.data == null) return helper.noData();
                if (snapshot.hasData) {
                  inicializarData(snapshot.data);
                }
                return scrollView(context, snapshot.data);
                break;
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return helper.noData();
            }
          }),
    );
  }

  SingleChildScrollView scrollView(BuildContext context, InfoReservaModel info) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          paginaFondo(),
          imagenPortada(context),
          cajaFormulario(context),
        ],
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
            style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _crearDropdown(),
                    _inputCantidad(),
                    _botonAgregar(),
                    helper.crearTitulo("Mi Carrito"),
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
        ),
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
          child: (creandoEnlace) ? Text("Espere por Favor...") : Text("Continuar"),
          color: Colors.blueAccent,
          textColor: Colors.white,
          padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: (creandoEnlace) ? null : continuar,
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
      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
      textAlign: TextAlign.center,
      //envia un paramettro inplicito
      validator: helper.isNumeric,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'ingrese numero de asientos'),
      onSaved: (String valor) {
        cantidadSeleccionada = int.parse(valor);
      },
    );
  }

  Widget _labelTotal() {
    total = 0.00;
    asientosPrecio.forEach((element) {
      total += (element.cantidad) * (element.pasaje);
    });

    return Row(
      children: <Widget>[
        Text(
          "Total:",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.lightBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          "\$${total.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.lightBlue,
          ),
        )
      ],
    );
  }

  Widget _botonAgregar() {
    return RaisedButton.icon(
      icon: Icon(Icons.shopping_cart),
      label: Text("Agregar a mi carrito"),
      color: Colors.blue,
      textColor: Colors.white,
      focusColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {
        if (formKey.currentState.validate()) {
          //para ejecutar el on save
          formKey.currentState.save();
          setState(() {
            agregarACarrito();
          });
        }
      },
    );
  }

  Widget _crearDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          helper.crearTitulo("Seleccione el tipo de asiento"),
          SizedBox(
            height: 3.0,
          ),
          DropdownButtonFormField(
              isExpanded: true,
              decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
              icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
              value: _precioSeleccionado,
              items: opcionesDropdown(),
              onChanged: (opt) {
                setState(() {
                  _precioSeleccionado = opt;
                  print(_precioSeleccionado.id.toString());
                });
              }),
        ],
      ),
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
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: listaIttem,
      ),
    );
  }

  Widget _crearItemCarrito(Precios precioSeleccionado) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          eliminarCarrito(precioSeleccionado.id);
        });
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${precioItem.titulo}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '\$${precioItem.pasaje.toString()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          value: precioItem));
    });

    return lista;
  }

  Future<WompiModel> _crearEnlacePago(DetalleTurModel detalle) async {
    creandoEnlace = true;
    setState(() {});
    final turServices = new TurServices();

    final WompiModel wompiModel = await turServices.guardarReserva(detalle);
    // helper.redireccionar(context, wompiModel.urlEnlace);
    creandoEnlace = false;
    setState(() {});
    print(wompiModel.urlEnlace);
    return wompiModel;
  }

  void continuar() async {
    formKey.currentState.validate();
    String descripcionProducto = "";
    total = 0.0;
    int cantidadAsientos = 0;
    if (asientosPrecio.length == 0) {
      helper.mostrarMensanjeError(context, "El carrito esta vacio.");
      return;
    }

    asientosPrecio.forEach((element) {
      double subTotal = (element.cantidad * element.pasaje);
      total += subTotal;
      cantidadAsientos += element.cantidad;
      descripcionProducto +=
          '${element.cantidad.toString()} X Asiento(s) ${element.titulo} \$${element.pasaje} c/u, Sub Total \$$subTotal\n';
    });
    descripcionProducto += '\n  Total: \$$total \n';
    if (cantidadAsientos > infoReservaModel.cupos) {
      helper.mostrarMensanjeError(context, "Solo hay ${infoReservaModel.cupos} asientos disponibles");
      return;
    }
    _desicionTipo(descripcionProducto, cantidadAsientos);
  }

  void _desicionTipo(String descripcionProducto, int cantidadAsientos) async {
    final detalle = new DetalleTurModel(
        idCliente: 7,
        idTours: widget.tourPaqueteModel.idTours,
        nombreProducto: widget.tourPaqueteModel.nombreTours,
        descripcionProducto: '$descripcionProducto',
        descripcionTurPaquete: widget.tourPaqueteModel.descripcionTur,
        cantidadAsientos: cantidadAsientos,
        total: total,
        asientosSeleccionados: 'NO_SELECCIONADO',
        labelAsiento: 'NO_LABEL');
    String tipo = widget.tourPaqueteModel.tipo;
    if (tipo == 'Paquete Internacional' || tipo == 'Paquete Nacional') {
      //SI ES UN TUR REDIRECCIONAMOS PARA QUE SELECCIONE EL PAQUETE
      TransporteModel transporteModel = infoReservaModel.transporte;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeleccionarAsiento(
            detalle: detalle,
            transporte: transporteModel,
          ),
        ),
      );
      return;
    } else {
      //SINO CREAMOS ENLACE DE PAGO Y LO REDIRECCIONAMOS A LA PASARELA
      await _crearEnlacePago(detalle);
    }
  }

  void inicializarData(InfoReservaModel info) {
    if (infoReservaModel == null) {
      print("inicializando");
      infoReservaModel = info;

      //OCUPAREMES ESTA LISTA DE PRECIOS PARA LLENAR EL SELECT
      listaPrecios = [];
      listaPrecios.add(Precios(asiento: 1, pasaje: info.precio, titulo: "Normal"));
      //AGREMAMOS LAS PROMOCIONES EXISTENTES SI LAS EXISTE
      info.promociones.forEach((element) {
        listaPrecios.add(new Precios(
            titulo: element['titulo'],
            asiento: int.parse(element['asiento']),
            pasaje: double.parse(element['pasaje'])));
      });
      _precioSeleccionado = listaPrecios[0];
    }
  }

  void agregarACarrito() {
    final encontrado = asientosPrecio.indexWhere((pre) => pre.id == _precioSeleccionado.id);
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
}
