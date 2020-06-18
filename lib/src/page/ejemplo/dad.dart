import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
class MenuProvider{
  List<dynamic> opciones =[];
  
  
  MenuProvider(){
   // cargarData();
  }

 Future<List<dynamic>>  cargarData()  async{
  final respuesta = await  rootBundle.loadString('data/menu-opts.json');
     Map dataMap = json.decode(respuesta);
     print('esta dentro de cargar data ');
    // print(dataMap['rutas']);
     opciones =(dataMap['rutas']);

     return opciones;
  }
}
final menuProvider = new MenuProvider();