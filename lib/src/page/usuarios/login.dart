import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  static String tag = 'login-page';

   @override
   
  _LoginPageState createState() => _LoginPageState();
  
}
  class _LoginPageState extends State<Login> {
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

    final password = TextFormField(
      autofocus: false,
      initialValue: 'Contraseña',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
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
        child: Text('Iniciar Sesion', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
      '¿Olvidastes tu contraseña?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage("assets/img/2.png"), fit: BoxFit.cover,),
          ),
        ),
        new Center(
         child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[   
           
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 10.0),
            loginButton,
            
            forgotLabel
          ],
        ),
      ),
      ],
    )
  );
  }
  }