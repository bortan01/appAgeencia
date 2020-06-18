 import 'dart:async';

import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  ScrollController _sc = new ScrollController();
  List<int> listaNumeros = new List();
  int ultimoIthem = 0;
  bool estacargando = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agregar10();

    _sc.addListener((){
    //  print('scroll');
      if(_sc.position.pixels == _sc.position.maxScrollExtent){
        //agregar10();
        fetchData();
      }
    });

  }

  /// para destruir el scroll y evitar fuga de memoria
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _sc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("kistas builder "),
        ),
        body: Stack(
          children: <Widget>[
            crearLoading(),
            crearLista()
          ],
        ),
    );
  }

  crearLista() {
    return new RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        controller: _sc ,
        itemBuilder: (BuildContext context, int indice) {
          final imagen = listaNumeros[indice];
          return FadeInImage(
            //image: NetworkImage('https://i.picsum.photos/id/$indice/500/300.jpg'),
              image: NetworkImage('https://depor.com/resizer/prCaSKUOIsjvn-7FxYmYBXUZN7E=/980x528/smart/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/TOJWE7V4LJHFRJ6U5NIIUPJFNM.jpg'),

            placeholder: AssetImage('assets/gif/loading.gif'),
          );
        },
        itemCount: listaNumeros.length,
      ),
    );
  }


  void agregar10() {
    for (var i = 0; i < 4; i++) {
      ultimoIthem ++;
      listaNumeros.add(ultimoIthem);
      setState(() {});
    }
  }


  Future<void> fetchData()async {
    Duration duration = new Duration(seconds:  5);
    estacargando =true;
    setState(() {});

    return new Timer(duration,respuestaHttp );


  }

  void respuestaHttp(){
     estacargando = false;
     agregar10();
     _sc.animateTo(_sc.position.pixels +100, duration: new Duration(milliseconds: 250), curve: Curves.fastOutSlowIn);
  }

  crearLoading() {
    if(estacargando){
      return new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              CircularProgressIndicator()
            ],
          ),
          SizedBox(height: 15.0)
        ],
      );
    }else{
      return Container();
    }
  }






  Future<Null> obtenerPagina1()async {
   final Duration duration = new Duration(seconds: 2);
   new Timer(duration, (){
      listaNumeros.clear();
      ultimoIthem+=20;
      agregar10();
    });
   return Future.delayed(duration);
  }
}
