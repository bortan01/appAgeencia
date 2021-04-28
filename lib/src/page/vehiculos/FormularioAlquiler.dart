import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo/vehiculo_model.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class Alquiler extends StatefulWidget {
  final Auto carro;
  final List<OpcioneAdicional> opciones;
  const Alquiler({Key key, this.carro, this.opciones}) : super(key: key);

  @override
  _AlquilerState createState() => _AlquilerState();
}

class _AlquilerState extends State<Alquiler> {
  Color fondo = Colors.green;
  double screenHeight;
  List<OpcioneAdicional> opcionesSeleccionadas = [];
  List<OpcioneAdicional> listaOpciones = [];
  int cantidadSeleccionada = 1;
  int numeroDias = 1;
  double total = 0.0;
  OpcioneAdicional opcionSelecionada;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    inicializarListaOpciones(widget.opciones);
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
              cajaFormulario(context, widget.carro),
            ],
          ),
        ));
  }

  Widget appBarCarrito() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Cotizar Vehículo"),
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

  Widget cajaFormulario(BuildContext context, Auto carro) {
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
                    helper.crearTitulo('${carro.marca} ${carro.modelo} ${carro.anio} (\$${carro.precioDiario}/Día) '),
                    _inputCantidadDias(),
                    helper.crearTitulo("Seleccione servicos adicionales"),
                    _crearDropdown(),
                    _inputCantidad(),
                    _botonAgregar(),
                    helper.crearTitulo("Servicios adicionales seleccionados"),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)), labelText: 'ingrese cantidad'),
      onSaved: (String valor) {
        cantidadSeleccionada = int.parse(valor);
      },
    );
  }

  Widget _inputCantidadDias() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 10.0, bottom: 8.0),
      child: TextFormField(
        initialValue: "1",
        keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
        textAlign: TextAlign.center,
        validator: helper.isNumeric,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)), labelText: 'ingrese numero de Dias'),
        onSaved: (String valor) {
          numeroDias = int.parse(valor);
        },
        onChanged: (String valor) {
          numeroDias = int.parse(valor);
          setState(() {});
        },
      ),
    );
  }

  Widget _labelTotal() {
     total = 0.00;
    total += widget.carro.precioDiario * numeroDias;

    opcionesSeleccionadas.forEach((element) {
      total += (element.cantidadSeleccionada) * (element.precio);
    });
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Vehículo +", overflow: TextOverflow.ellipsis, maxLines: 3, style: helper.titulo2()),
            Text("Servicios Adicionales:", overflow: TextOverflow.ellipsis, maxLines: 3, style: helper.titulo2()),
          ],
        ),
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
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
              hintText: "", border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)))),
          icon: Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
          value: listaOpciones[0],
          items: opcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              opcionSelecionada = opt;
            });
          }),
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
    opcionesSeleccionadas.forEach((element) {
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

  Widget _crearItemCarrito(OpcioneAdicional opcionElegida) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          eliminarCarrito(opcionElegida.idserviciosOpc);
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
            '${opcionElegida.cantidadSeleccionada.toString()}',
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        title: Text(
          '${opcionElegida.nombreServicio}',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        subtitle: Text(
          'subTotal \$${(opcionElegida.cantidadSeleccionada * opcionElegida.precio).toStringAsFixed(2)}',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 13.0, color: Colors.white),
        ),
      ),
    );
  }

  List<DropdownMenuItem<OpcioneAdicional>> opcionesDropdown() {
    List<DropdownMenuItem<OpcioneAdicional>> lista = new List();
    listaOpciones.forEach((precioItem) {
      lista.add(DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${precioItem.nombreServicio}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '\$${precioItem.precio.toString()}',
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
    final encontrado =
        opcionesSeleccionadas.indexWhere((pre) => pre.idserviciosOpc == opcionSelecionada.idserviciosOpc);
    if (encontrado == -1 && opcionSelecionada != null) {
      opcionSelecionada?.cantidadSeleccionada = cantidadSeleccionada;
      opcionesSeleccionadas.add(opcionSelecionada);
    } else {
      opcionesSeleccionadas.forEach((element) {
        if (element.idserviciosOpc == opcionSelecionada.idserviciosOpc) {
          element.cantidadSeleccionada = cantidadSeleccionada;
          return;
        }
      });
    }
  }

  void eliminarCarrito(id) {
    opcionesSeleccionadas.removeWhere((element) => element.idserviciosOpc == id);
  }

  void inicializarListaOpciones(List<OpcioneAdicional> opciones) {
    listaOpciones = [];
    listaOpciones = opciones;
    if (opciones.isNotEmpty) {
      opcionSelecionada = opciones[0];
    }
  }
}
