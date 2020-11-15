import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:peliculas/src/page/helpers/helper.dart';
import 'package:peliculas/src/page/maps/acceso_gps_page.dart';
import 'package:peliculas/src/page/maps/mapa_page.dart';

class LoadingPage extends StatefulWidget {
  // const name({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    ///PARA DETECTAR EL CAMBIO DE LA APLICACION
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocatication(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(child: new Text(snapshot.data));
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 8,
              ),
            );
          }
        },
      ),
    );
  }

  Future checkGpsLocatication(BuildContext context) async {
    //para saver si tengo el permiso
    final permisoGPS = await Permission.location.isGranted;
    // PARA DETERMINAR SI TENEMOS PERMISOS GPS
    final gpsActivo = await Geolocator.isLocationServiceEnabled();
    if (permisoGPS && gpsActivo) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, MapaPage()));
      return "";

      ///esto va al snapshop.data
    } else if (!permisoGPS) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return "Es necesario el permiso de gps";
    } else {
      return "Active el GPS";
    }
  }
}
