import 'package:flutter/material.dart';


class Codigo extends StatefulWidget {
  static String tag = 'codigo-page';

   @override
   
  _CodigoPageState createState() => _CodigoPageState();
  
}
  class _CodigoPageState extends State<Codigo> {
  @override
  Widget build(BuildContext context) {
   
    final inputCodigo = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '10102040',
      decoration: InputDecoration(
        hintText: 'Código de verificación',
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
         
          Navigator.pushNamed(context, 'nuevaContra');
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
            image: new DecorationImage(image: new AssetImage("assets/img/codigo.jpeg"), fit: BoxFit.cover,),
          ),
        ),
        new Center(
         child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[   
           
            inputCodigo,
            SizedBox(height: 1.5),
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
