import 'package:peliculas/src/page/dad.dart';
import 'package:peliculas/src/utils/icono_string_util.dart';

import 'package:flutter/material.dart';

class HomeComponents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("componentes"),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
//    menuProvider.cargarData().
//    then((opciones){
//      print('imprimiendo desde lista');
//      print(opciones);
//    });

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {

        return ListView(
          children: _crearListaItem(snapshot.data, context),
        );
      },
      future: menuProvider.cargarData(),
      initialData: [],
    );
   }

  List<Widget> _crearListaItem(List<dynamic> data, BuildContext context) {
   final List<Widget> opciones = [];

   if(data == null){
      return [];
   }

    data.forEach((opt){
      final widgetTemp = ListTile (
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.arrow_forward, color: Colors.blueAccent),
        onTap: (){
//          final ruta = MaterialPageRoute(
//            builder: (contex){
//              return AlertPage();
//            }
//          );
//          Navigator.push(context, ruta);
        Navigator.pushNamed(context, opt['ruta']);
        }, 

      );
      opciones.add(widgetTemp);
      opciones.add(new Divider());
    });


   return opciones;
  }
}
