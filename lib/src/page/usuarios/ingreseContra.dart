import 'package:flutter/material.dart';


class IngreseContra extends StatefulWidget {
  static String tag = 'codigo-page';

   @override
   
  _IngreseContraPageState createState() => _IngreseContraPageState();
  
}
  class _IngreseContraPageState extends State<IngreseContra> {
  @override
  Widget build(BuildContext context) {
   
   final password_1 = TextFormField(
      autofocus: false,
      initialValue: 'Contraseña',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
   final password_2 = TextFormField(
      autofocus: false,
      initialValue: 'Contraseña',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
   
    final enviarButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
         
          Navigator.pushNamed(context, 'bienvenidoos');
        },
        padding: EdgeInsets.all(12),
        color: Colors.blue,
        child: Text('Enviar', style: TextStyle(color: Colors.white)),
      ),
    );

    final cancelarButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
         
          Navigator.pushNamed(context, 'bienvenidoos');
        },
        padding: EdgeInsets.all(12),
        color: Colors.blueGrey,
        child: Text('Cancelar', style: TextStyle(color: Colors.white)),
      ),
    );


    return Scaffold(
      body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage("assets/img/nueva.jpeg"), fit: BoxFit.cover,),
          ),
        ),
        new Center(
         child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[   
           SizedBox(height: 40.0),
            password_1,
            SizedBox(height: 30.0),
            password_2,
            SizedBox(height: 20.0),
            enviarButton,
            cancelarButton
          ],
        ),
      ),
      ],
    )
  );
  }
  }
