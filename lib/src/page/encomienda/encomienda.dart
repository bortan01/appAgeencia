import 'package:flutter/material.dart';
import 'package:peliculas/src/models/encomienda/encomienda_model.dart';
import 'package:peliculas/src/models/precios_model.dart';
import 'package:peliculas/src/services/encomienda_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class EncomiendaPage extends StatefulWidget {
  const EncomiendaPage({Key key}) : super(key: key);
  @override
  _EncomiendaPageState createState() => _EncomiendaPageState();
}

class _EncomiendaPageState extends State<EncomiendaPage> {
  Future<EncomiendaModel> futureEncomienda;
  Color fondo = Colors.green;
  double screenHeight;
  List<Precios> asientosPrecio = [];
  List<Precios> listaPrecios = [];
  int cantidadSeleccionada = 1;
  double total = 0.0;
  Precios _precioSeleccionado;
  String nombreUnidad = 'unidades';
  double porcentajeComision = 0.0;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    futureEncomienda = _getEncomienda();
  }

  Future<EncomiendaModel> _getEncomienda() async {
    final respuesta = await EncomiendaServices().obtenerEncomienda();
    inicializarListaPrecios(respuesta.product);
    porcentajeComision = respuesta.comision[0].porcentaje;
    return respuesta;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBarCarrito(),
      body: FutureBuilder(
          future: futureEncomienda,
          builder: (BuildContext context, AsyncSnapshot<EncomiendaModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.data == null) return helper.noData();
                return scrollView(context);
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
      title: Text("Cotizador de Encomiendas"),
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
                    crearTitulo("Productos seleccionados"),
                    crearSubTitulo("(Mueva a los lados para eliminar)"),
                    SizedBox(height: 4.0),
                    _crearCarrito(),
                    SizedBox(height: 5.0),
                    _labelTotal(),
                  ],
                ),
              ),
            ),
          ),
        ),
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
          labelText: 'ingrese numero de $nombreUnidad'),
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
    //sumando la comision
    total += total * (porcentajeComision / 100);

    return Row(
      children: <Widget>[
        Text("Total + Gastos de envio:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
        Spacer(),
        Text("\$${total.toStringAsFixed(2)}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600))
      ],
    );
  }

  Widget _botonAgregar() {
    return RaisedButton.icon(
      icon: Icon(Icons.add),
      label: Text("Agregar"),
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
          crearTitulo("Seleccione los producto"),
          SizedBox(
            height: 3.0,
          ),
          DropdownButtonFormField(
              isExpanded: true,
              decoration: InputDecoration(
                  hintText: "",
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

  void agregarACarrito() {
    final encontrado = asientosPrecio.indexWhere((pre) => pre.id == _precioSeleccionado.id);
    if (encontrado == -1 && _precioSeleccionado != null) {
      _precioSeleccionado?.cantidad = cantidadSeleccionada;
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

  void inicializarListaPrecios(List<Product> products) {
    listaPrecios = [];
    products.forEach((prod) {
      listaPrecios.add(new Precios(titulo: prod.nombreProducto, pasaje: prod.tarifa, asiento: 1, cantidad: 1));
    });
  }
}
