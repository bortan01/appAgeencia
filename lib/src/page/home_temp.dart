import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageTemp extends StatelessWidget {
  final opciones = ['uno', 'dos' , 'tres', 'cuatro', 'cinco'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Componentes temp"),
        ),
        body: ListView(
          children: _crearitems()
        )
    );
  }

List<Widget>_crearitems(){

    List<Widget> lissta = new List<Widget>();

    for(String item in opciones){
        final tempWidget = ListTile(
          title: Text(item),
        );
        lissta.add(tempWidget);
        lissta.add(new Divider(color: Colors.redAccent, height: 2.0,));
    }

    return lissta;
}
}
