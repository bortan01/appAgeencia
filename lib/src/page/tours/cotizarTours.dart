import 'package:flutter/material.dart';

class CotizarTours extends StatefulWidget {
  @override
  _CotizarToursState createState() => _CotizarToursState();
}

class _CotizarToursState extends State<CotizarTours> {
  int asiento_izquierdo;
  int asiento_derecho;
  int filas;

  double screenHeight;

  String _nombre = "";
  String _telefono = "";
  String _direccionPais = "";

  String _fechaViaje = "";
  String _fechaRetorno = "";

  String _sitios = "";
  String _adultos = "";
  String _bebe = "";
  String _ninos = "";
  String _ancianos = "";

  TextEditingController _controllerFecha = new TextEditingController();
  TextEditingController _controllerFechaD = new TextEditingController();
  String opcionSeleccionada = 'Tipo de Viaje';

  List<String> _lugar = [
    'Tipo de Viaje',
    'Familiar',
    'Vacaciones',
    'Luna de Miel',
    'otros'
  ];

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
      title: Text("Cotizar Tours"),
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
                      "Cotizar Tours",
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
                  _inputTelefono(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearDropdown(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputPais(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearFecha(context),
                  SizedBox(
                    height: 20,
                  ),
                  _crearFechaRetorno(context),
                  SizedBox(
                    height: 20,
                  ),
                  _inputSitiosTuristicos(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputBebes(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputNinos(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputAdultos(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputAncianos(),
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
      keyboardType: TextInputType.number,
      onChanged: (String persona) {
        _telefono = persona;
        setState(() {});
      },
    );
  }

  Widget _inputPais() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Destino a Visitar',
        labelText: 'Digite el País que desea visitar',
        helperText: 'Destino a Visitar',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.map),
      ),
      onChanged: (String persona) {
        _direccionPais = persona;
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

  Widget _crearFecha(BuildContext context) {
    return new TextField(
      controller: _controllerFecha,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Fecha del Viaje',
        labelText: 'Fecha del Viaje',
        helperText: 'Fecha del Viaje',
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
        _fechaViaje = picked.toString();
        _controllerFecha.text = _fechaViaje;
      });
    }
  }
  //Fecha de Devolucion

  Widget _crearFechaRetorno(BuildContext context) {
    return new TextField(
      controller: _controllerFecha,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Fecha de Retorno',
        labelText: 'Fecha de Retorno',
        helperText: 'Fecha de Retorno del Viaje',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDateRetorno(context);
      },
    );
  }

  _selectDateRetorno(BuildContext context) async {
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
        _controllerFechaD.text = _fechaViaje;
      });
    }
  }

  Widget _inputSitiosTuristicos() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite Sitios Turísticos',
        labelText: 'Digite Sitios Turísticos',
        helperText: 'Sitios Turísticos que desee visitar',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.map),
      ),
      onChanged: (String sitio) {
        _sitios = sitio;
        setState(() {});
      },
    );
  }

  Widget _inputBebes() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite cantidad de Bebés que viajarán',
        labelText: 'Digite cantidad de Bebés',
        helperText: 'Cantidad de Bebés que viajarán',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.child_care),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String bebe) {
        _bebe = bebe;
        setState(() {});
      },
    );
  }

  Widget _inputNinos() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite cantidad de Niños que viajarán',
        labelText: 'Digite cantidad de Niños',
        helperText: 'Cantidad de Niños que viajarán',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.child_care),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String nino) {
        _ninos = nino;
        setState(() {});
      },
    );
  }

  Widget _inputAdultos() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite cantidad de Adultos que viajarán',
        labelText: 'Digite cantidad de Adultos',
        helperText: 'Cantidad de Adultos que viajarán',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String adultos) {
        _adultos = adultos;
        setState(() {});
      },
    );
  }

  Widget _inputAncianos() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite cantidad de Adultos Mayores que viajarán',
        labelText: 'Digite cantidad de Adultos',
        helperText: 'Cantidad de Adultos Mayores que viajarán',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String ancianos) {
        _ancianos = ancianos;
        setState(() {});
      },
    );
  }
}
