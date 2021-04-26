import 'package:flutter/material.dart';

class CotizarAuto extends StatefulWidget {
  @override
  _CotizarAutoState createState() => _CotizarAutoState();
}

class _CotizarAutoState extends State<CotizarAuto> {
  double screenHeight;

//datos generales del cliente
  String _nombre = "";
  String _correo = "";
  String _telefono = "";
  String _direccion = "";

//fecha de entrega y retorno del vehiculo
  String _fechaEntrega = "";
  String _fechaRetorno = "";

  TextEditingController _controllerFecha = new TextEditingController();
  TextEditingController _controllerFechaR = new TextEditingController();

  String opcionSeleccionada = 'Servicio a Domicilio';

  List<String> _lugar = [
    'Servicio a Domicilio',
    'Aeropuerto',
    'Ciudad',
    'otros'
  ];

  String opcionTransmicion = 'Transmición';

  List<String> _transmicion = [
    'Transmición',
    'Estandar',
    'Automatica',
    'otros'
  ];

//Caracteristicas de Vehiculo
  String _marca = "";
  String _modelo = "";
  String _ano = "";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBarAlquiler(),
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

  Widget appBarAlquiler() {
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
                    child: Text(
                      "Cotizar Vehículo",
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
                  _inputNombre(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputCorreo(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputTelefono(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputDireccion(),
                  SizedBox(
                    height: 20,
                  ),
                  _fechaEntregaAuto(context),
                  SizedBox(
                    height: 20,
                  ),
                  _entregaVehiculo(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearFechaDevolucion(context),
                  SizedBox(
                    height: 20,
                  ),
                  _inputMarca(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputModelo(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputanio(),
                  SizedBox(
                    height: 20,
                  ),
                  _transmicionVehiculo(),
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
                        child: Text("Enviar Cotización"),
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
      keyboardType: TextInputType.text,
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

  Widget _inputCorreo() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Correo Electrónico',
        labelText: 'Digite su Correo Electrónico',
        helperText: 'Correo Electrónico',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.email),
      ),
      onChanged: (String persona) {
        _correo = persona;
        setState(() {});
      },
    );
  }

  Widget _inputTelefono() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Número de Teléfono',
        labelText: 'Digite su Número de Teléfono',
        helperText: 'Número de Teléfono',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.phone),
      ),
      onChanged: (String persona) {
        _telefono = persona;
        setState(() {});
      },
    );
  }

  Widget _inputDireccion() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite Dirección',
        labelText: 'Digite su Dirección Completa',
        helperText: 'Dirección Completa',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.map),
      ),
      onChanged: (String persona) {
        _direccion = persona;
        setState(() {});
      },
    );
  }

  //Fecha de Entrega

  Widget _fechaEntregaAuto(BuildContext context) {
    return new TextField(
      controller: _controllerFecha,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Fecha de Entrega',
        labelText: 'Fecha de Entrega',
        helperText: 'Fecha en que Necesita el Vehiculo',
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
        _fechaEntrega = picked.toString();
        _controllerFecha.text = _fechaEntrega;
      });
    }
  }

  //forma de entrega de vehiculo
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

  Widget _entregaVehiculo() {
    return new Row(
      children: <Widget>[
        new Icon(Icons.person_pin_circle),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
              value: opcionSeleccionada,
              items: getOpcionesDropdown(),
              onChanged: (opt) {
                setState(() {
                  opcionSeleccionada = opt;
                });
              }),
        )
      ],
    );
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
        _fechaRetorno = picked.toString();
        _controllerFechaR.text = _fechaRetorno;
      });
    }
  }

  Widget _inputMarca() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite Marca del Vehículo',
        labelText: 'Digite Marca del Vehículo',
        helperText: 'Marca del Vehículo',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.local_car_wash),
      ),
      onChanged: (String persona) {
        _marca = persona;
        setState(() {});
      },
    );
  }

  Widget _inputModelo() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite Modelo del Vehículo',
        labelText: 'Digite Modelo del Vehículo',
        helperText: 'Modelo del Vehículo',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.drive_eta),
      ),
      onChanged: (String persona) {
        _modelo = persona;
        setState(() {});
      },
    );
  }

  Widget _inputanio() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite Año',
        labelText: 'Digite Año del Vehículo',
        helperText: 'Numero Año del Vehículo',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onChanged: (String persona) {
        _ano = persona;

        setState(() {});
      },
    );
  }

//Transmicion del Vehiculo
  List<DropdownMenuItem<String>> getTransmicion() {
    List<DropdownMenuItem<String>> listat = new List();
    _transmicion.forEach((lugar) {
      listat.add(DropdownMenuItem(
        child: new Text(lugar),
        value: lugar,
      ));
    });
    return listat;
  }

  Widget _transmicionVehiculo() {
    return new Row(
      children: <Widget>[
        new Icon(Icons.person_pin_circle),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
              value: opcionTransmicion,
              items: getTransmicion(),
              onChanged: (opt) {
                setState(() {
                  opcionTransmicion = opt;
                });
              }),
        )
      ],
    );
  }
}
