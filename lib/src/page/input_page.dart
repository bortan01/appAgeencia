

import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _nombre = "";
  String _email = "";
  String _fecha = "";
  String opcionSeleccionada = "volar";
  List _poderes = ['volar' , 'rashos X', 'super aliento' , 'super fuerza'];
  TextEditingController _controllerFecha = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("imput de text"),
      ),
      body: new ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        children: <Widget>[
          _crearInput(),
          Divider(),
          _crearEmail(),
          new Divider(),
          _crearPassword(),
          new Divider(),
          _crearFecha(context),
          new Divider(),
          _crearDropDown(),
          new Divider(),
          _crearPersona(),
        ],
      ),
    );
  }

  Widget _crearInput() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: new Text("Letras ${_nombre.length}"),
          hintText: 'esto es el hint ',
          labelText: 'nombre',
          helperText: 'solo debes de poner el nombre',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
      onChanged: (String valor) {
        _nombre = valor;
        setState(() {});
      },
    );
  }

  Widget _crearPersona() {
    return new ListTile(
      title: new Text("el nombre es $_nombre"),
      subtitle: new Text("el email es $_email"),
      trailing: new Text(opcionSeleccionada),
    );
  }

  Widget _crearEmail() {
    return new TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'email',
          labelText: 'nombre',
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(Icons.email)),
      onChanged: (String valor) {
        _email = valor;

        setState(() {});
      },
    );
  }

  Widget _crearPassword() {
    return new TextField(
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'password',
          labelText: 'password',
          suffixIcon: Icon(Icons.lock_open),
          icon: Icon(Icons.lock)),

    );
  }

  Widget _crearFecha(BuildContext context) {
    return new TextField(
      controller: _controllerFecha,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Fecha de nacimiento',
          labelText: 'Escribe la fecha ',

          suffixIcon: Icon(Icons.calendar_today),
          icon: Icon(Icons.calendar_view_day)),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context)async{
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2025 ),
      locale: Locale('es'),

    );

    if(picked != null){
      setState(() {
        _fecha = picked.toString();
        _controllerFecha.text = _fecha;
      });
    }
  }

  Widget _crearDropDown() {
    return new Row(

      children: <Widget>[

        new Icon(Icons.select_all),
        SizedBox(width: 30.0,),
        Expanded(
          child: DropdownButton(
              value: opcionSeleccionada,
              items: getItemDropdown(),

              onChanged: (opt){
                setState(() {
                  opcionSeleccionada = opt;
                });
              }
          ),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getItemDropdown(){
    List<DropdownMenuItem<String>> lista = new List();
     _poderes.forEach((poder){
       lista.add(DropdownMenuItem(
          child: new Text(poder) ,
          value: poder,
       )
       );
     });
     return lista;
  }





}
