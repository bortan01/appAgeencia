import 'package:flutter/material.dart';

class EncomiendaPage extends StatefulWidget {
  @override
  _EncomiendaPageState createState() => _EncomiendaPageState();
}

class _EncomiendaPageState extends State<EncomiendaPage> {
  String _cantidad = "";
  String _direccion = "";
  String _destino_final = "";
  String _total="35.50";
  String opcionSeleccionada = "Producto";
  List _productos = ['Producto', 'Medicamentos', 'Jeringas', 'otros'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Cotizador Encomienda"),
      ),
      body: new ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        children: <Widget>[
          _crearDropDown(),
          new Divider(),
          _crearInput_cantidad(),
          new Divider(),
          _crearInput_dir(),
          new Divider(),
          _crearInput_dir_final(),
          new Divider(),
          _crearPersona(),
          new Divider(),
          _createTotal()
        ],
      ),
    );
  }

  Widget _crearInput_dir() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: new Text("Letras ${_direccion.length}"),
          hintText: 'Dirección actual',
          labelText: 'Dirección',
          helperText: 'Debes digitar la dirección',
          suffixIcon: Icon(Icons.airport_shuttle),
          icon: Icon(Icons.spellcheck)),
      onChanged: (String valor) {
        _direccion = valor;
        setState(() {});
      },
    );
  }

  Widget _crearInput_dir_final() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: new Text("Letras ${_destino_final.length}"),
          hintText: 'Dirección final',
          labelText: 'Dirección final',
          helperText: 'Debes digitar la dirección',
          suffixIcon: Icon(Icons.add_location),
          icon: Icon(Icons.spellcheck)),
      onChanged: (String valor) {
        _destino_final = valor;
        setState(() {});
      },
    );
  }

  Widget _crearInput_cantidad() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'lbs',
          labelText: 'lbs',
          helperText: 'Debes digitar la cantidad de libras',
          suffixIcon: Icon(Icons.playlist_add_check),
          icon: Icon(Icons.spellcheck)),
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
      subtitle: new Text("Direccón Final: $_destino_final"),
     
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
