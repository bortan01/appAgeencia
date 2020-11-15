import 'package:flutter/material.dart';
import 'package:peliculas/src/page/helpers/helper.dart';
import 'package:peliculas/src/page/maps/acceso_gps_page.dart';
import 'package:peliculas/src/page/maps/mapa_page.dart';

class LoadingPage extends StatelessWidget {
  // const name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocatication(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 10,
          ));
        },
      ),
    );
  }

  Future checkGpsLocatication(BuildContext context) async {
    // PERMISO GPS
    // GPS ESTA ACTIVO
    await Future.delayed(new Duration(milliseconds: 1000));
    print("loading hola mundo ");
    Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsPage()));
    // Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
  }
}
