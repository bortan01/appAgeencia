import 'package:flutter/material.dart';

class Alquiler extends StatefulWidget {
  @override
  _AlquilerPageState createState() => _AlquilerPageState();
}

class _AlquilerPageState extends State<Alquiler> {
  double screenHeight;

  String _nombre = "";
  String _telefono = "";
  String _direccionRecogida = "";
  String _direccionDevolucion = "";
  String _lugarRecogida = "";
  String _lugarRecogidaFnal = "";
  String _fechaR = "";
  String _fechaD = "";
  TextEditingController _controllerFecha = new TextEditingController();
  TextEditingController _controllerFechaD = new TextEditingController();
  String opcionSeleccionada = 'Servicio a Domicilio';

  List<String> _lugar = [
    'Servicio a Domicilio',
    'Aeropuerto',
    'Ciudad',
    'otros'
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Rerservar Vehículo",
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
                  _inputNombre(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputTelefono(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearDropdown(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputDireccionRecogida(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearFecha(context),
                  SizedBox(
                    height: 20,
                  ),
                  _crearDropdownDevolucion(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputDireccionDevolucion(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearFechaDevolucion(context),
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
                        color: Color(0xFF4B9DFE),
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

  Widget _inputNombre() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Nombre',
        labelText: 'Digite su Nombre Completo',
        helperText: 'Nombre Completo',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.supervised_user_circle),
      ),
      onChanged: (String persona) {
        _nombre = persona;
        setState(() {});
      },
    );
  }

  Widget _inputTelefono() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Numero de Telefono',
        labelText: 'Digite su Numero de Telefono',
        helperText: 'Numero de Telefono',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.phone),
      ),
      onChanged: (String persona) {
        _telefono = persona;
        setState(() {});
      },
    );
  }

  Widget _inputDireccionRecogida() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite dirección',
        labelText: 'Digite la Dirección de Recogida',
        helperText: 'Dirección Completa',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.map),
      ),
      onChanged: (String persona) {
        _direccionRecogida = persona;
        setState(() {});
      },
    );
  }

  Widget _inputDireccionDevolucion() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite de Devolución',
        labelText: 'Dirección de Devolución',
        helperText: 'Dirección Completa',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.map),
      ),
      onChanged: (String persona) {
        _direccionDevolucion = persona;
        setState(() {});
      },
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    _lugar.forEach((lugar) {
      lista.add(DropdownMenuItem(
        child: new Text(lugar),
        value: lugar,
      ));
    });
    return lista;
  }

  Widget _crearDropdown() {
    return DropdownButton(
      value: opcionSeleccionada,
      items: getOpcionesDropdown(),
      onChanged: (opc) {
        setState(() {
          opcionSeleccionada = opc;
        });
      },
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDevolucionDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    _lugar.forEach((lugar) {
      lista.add(DropdownMenuItem(
        child: new Text(lugar),
        value: lugar,
      ));
    });
    return lista;
  }

  Widget _crearDropdownDevolucion() {
    return DropdownButton(
      value: opcionSeleccionada,
      items: getOpcionesDropdown(),
      onChanged: (opc) {
        setState(() {
          opcionSeleccionada = opc;
        });
      },
    );
  }

  Widget _crearFecha(BuildContext context) {
    return new TextField(
      controller: _controllerFecha,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Fecha de Recogida',
        labelText: 'Fecha de Recogida',
        helperText: 'Fecha en que Recogera el Vehiculo',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _fechaR = picked.toString();
        _controllerFecha.text = _fechaR;
      });
    }
  }
  //Fecha de Devolucion

  Widget _crearFechaDevolucion(BuildContext context) {
    return new TextField(
      controller: _controllerFecha,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Fecha de Devolución',
        labelText: 'Fecha de Devolución',
        helperText: 'Fecha de Devolución el Vehiculo',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDateDevolucion(context);
      },
    );
  }

  _selectDateDevolucion(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _fechaD = picked.toString();
        _controllerFechaD.text = _fechaR;
      });
    }
  }
}
