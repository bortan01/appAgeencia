import 'package:flutter/material.dart';


class Olvide extends StatefulWidget {
  static String tag = 'olvide-page';

   @override
   
  _OlvidePageState createState() => _OlvidePageState();
  
}
  class _OlvidePageState extends State<Olvide> {
  @override
  Widget build(BuildContext context) {
   
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'pineverdi@gmail.com',
      decoration: InputDecoration(
        hintText: 'Correo Electronico',
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

    final forgotLabel = FlatButton(
      child: Text(
      'Le enviaremos un correo de verificación',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
         
      },
    );

    return Scaffold(
      body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage("assets/img/recupera1.png"), fit: BoxFit.cover,),
          ),
        ),
        new Center(
         child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[   
           
            email,
            SizedBox(height: 1.5),

            forgotLabel,
            SizedBox(height: 28.0),
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
