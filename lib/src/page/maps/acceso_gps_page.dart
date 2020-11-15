import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
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
      if (await Permission.location.isGranted) {
        Navigator.pushNamed(context, "loading");
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Es necesario el GPS"),
            MaterialButton(
              child: Text("Solicitar Acceso",
                  style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              onPressed: () async {
                final status = await Permission.location.request();
                this.accesoGPS(context, status);
              },
            ),
          ],
        ),
      ),
    );
  }

  void accesoGPS(BuildContext context, PermissionStatus status) {
    print(status);
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, "mapa");
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
