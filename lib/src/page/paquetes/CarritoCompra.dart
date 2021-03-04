import 'package:flutter/material.dart';
import 'package:peliculas/src/models/precios_model.dart';
import 'package:peliculas/src/models/turs/detalleTur_model.dart';
import 'package:peliculas/src/models/turs/transporte_model.dart';
import 'package:peliculas/src/page/tours/seleccionarAsiento.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;
import 'package:rflutter_alert/rflutter_alert.dart';

class CarritoCompra extends StatefulWidget {
  final String idTur;
  const CarritoCompra({Key key, this.idTur}) : super(key: key);
  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  Future infoReserva;
  Color fondo = Colors.green;
  double screenHeight;
  Precios _precioSeleccionado;
  List<Precios> listaPrecios = [];
  List<Precios> asientosPrecio = [];
  int cantidadSeleccionada = 1;
  int cupos = 0;
  double total = 0.00;
  int cuposSolicitados = 0;
  String descripcion;
  String nombre;
  DetalleTurModel detalle = new DetalleTurModel();
  TransporteModel transporte;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    infoReserva = _getInfoReserva();
  }

  Future<dynamic> _getInfoReserva() async {
    return await TurServices().obtenerInfomacionToReserva(widget.idTur);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarCarrito(),
      body: FutureBuilder(
          future: infoReserva,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                inicializarData(snapshot.data);
                return scrollView(context);
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
          }),
    );
  }

  SingleChildScrollView scrollView(BuildContext context) {
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
              child: Form(
                key: formKey,
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
          child: Text("Continuar"),
          color: Colors.blueAccent,
          textColor: Colors.white,
          padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: continuar,
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
      keyboardType:
          TextInputType.numberWithOptions(decimal: false, signed: false),
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
        Text("Total:",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
        Spacer(),
        Text("\$${total.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600))
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
              Text(
                '${precioItem.titulo}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '\$${precioItem.pasaje.toString()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          value: precioItem));
    });

    return lista;
  }

  void inicializarData(dynamic data) {
    if (_precioSeleccionado == null) {
      print("inicializando");
      //el detalle sera enviado a la siguiente pantalla
      nombre = data['nombre'];
      descripcion = data['descripcion_tur'];
      transporte = new TransporteModel.fromJson(data['transporte']);
      //inicializaremos los datos para el dropdown
      cupos = int.parse(data['cupos']);
      listaPrecios = [];
      double precioNormal = double.parse(data['precio']);
      listaPrecios
          .add(Precios(asiento: 1, pasaje: precioNormal, titulo: "Normal"));
      List<dynamic> promociones = data['promociones'].toList();
      promociones.forEach((element) {
        listaPrecios.add(new Precios(
            titulo: element['titulo'],
            asiento: int.parse(element['asiento']),
            pasaje: double.parse(element['pasaje'])));
      });
      _precioSeleccionado = listaPrecios[0];
    }
  }

  void continuar() {
    formKey.currentState.validate();
    String descAdicional = "";
    cuposSolicitados = 0;
    if (asientosPrecio.length == 0) {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Oops",
        desc: "El carrito esta vacio.",
        buttons: [
          DialogButton(
            child: Text(
              "Cerrar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color.fromRGBO(0, 179, 134, 1.0),
          )
        ],
      ).show();
    } else {
      asientosPrecio.forEach((element) {
        cuposSolicitados += element.cantidad;
        String subTotal =
            (element.cantidad * element.pasaje).toStringAsFixed(2);
        descAdicional +=
            '${element.cantidad.toString()} X ${element.titulo} \$$subTotal \n';
      });
      descAdicional += '\n';

      if (cuposSolicitados > cupos) {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Oops",
          desc: "Solo hay $cupos asientos disponibles",
          buttons: [
            DialogButton(
              child: Text(
                "Cerrar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
            )
          ],
        ).show();
      } else {
        detalle.idTours = 1;
        detalle.idCliente = 3;
        detalle.nombreProducto = nombre;
        detalle.descripcionProducto = descAdicional + descripcion;
        detalle.total = total;
        detalle.cantidadAsientos = cuposSolicitados;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SeleccionarAsiento(
                    detalle: detalle, transporte: transporte)));
      }
    }
  }
}
