import 'package:flutter/material.dart';

class EncomiendaPage extends StatefulWidget {
  @override
  _EncomiendaPageState createState() => _EncomiendaPageState();
}

class _EncomiendaPageState extends State<EncomiendaPage> {
  double screenHeight;

  String _cantidad = "";
  String _direccion = "";
  String _destinoFinal = "";
  String _total="35.50";
  String opcionSeleccionada = 'Producto';
  List<String> _productos = ['Producto', 'Medicamentos', 'Jeringas', 'otros'];
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
                      "Cotizador de Encomienda",
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
                  _crearDropDown(),
                  SizedBox(
                    height: 20,
                  ),
                   _crearInputCantidad(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearInputDir(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearInputFinal(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearPersona(),
                  SizedBox(
                    height: 1,
                  ),
                  _createTotal(),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text("Cotizar"),
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

 
 

  Widget _crearInputDir() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: new Text("Letras ${_direccion.length}"),
          hintText: 'Dirección actual',
          labelText: 'Dirección',
          helperText: 'Debes digitar la dirección',
          suffixIcon: Icon(Icons.airport_shuttle)),
      onChanged: (String valor) {
        _direccion = valor;
        setState(() {});
      },
    );
  }

  Widget _crearInputFinal() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: new Text("Letras ${_destinoFinal.length}"),
          hintText: 'Dirección final',
          labelText: 'Dirección final',
          helperText: 'Debes digitar la dirección',
          suffixIcon: Icon(Icons.add_location)),
        
      onChanged: (String valor) {
        _destinoFinal = valor;
        setState(() {});
      },
    );
  }

  Widget _crearInputCantidad() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'lbs',
          labelText: 'lbs',
          helperText: 'Debes digitar la cantidad de libras',
          suffixIcon: Icon(Icons.playlist_add_check)),
         
      onChanged: (String valor) {
        _cantidad = valor;
        setState(() {});
      },
    );
  }

  Widget _crearPersona() {
    return new ListTile(
      trailing: new Text(opcionSeleccionada),
      title: new Text("Direccion inicial: $_direccion"),
      subtitle: new Text("Direccón Final: $_destinoFinal"),
     
    );
  }

  Widget _createTotal() {
    return new ListTile(
      trailing: new Text("Cantidad de lbs: $_cantidad"),
      title: new Text("Su Total es:  $_total"),
    );
  }


  Widget _crearDropDown() {
    return new Row(
      children: <Widget>[
        new Icon(Icons.select_all),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
              value: opcionSeleccionada,
              items: getItemDropdown(),
              onChanged: (opt) {
                setState(() {
                  opcionSeleccionada = opt;
                });
              }),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getItemDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    _productos.forEach((producto) {
      lista.add(DropdownMenuItem(
        child: new Text(producto),
        value: producto,
      ));
    });
    return lista;
  }



  
 
}
