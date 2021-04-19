import 'package:flutter/material.dart';
import 'package:peliculas/src/services/user_services.dart';

Widget getDrawerDefault(BuildContext context) {
  final colorBase = Theme.of(context).bottomAppBarColor;
  final estiloLetra = new TextStyle(color: colorBase);
  return Theme(
    data: Theme.of(context).copyWith(canvasColor: Theme.of(context).primaryColor.withOpacity(0.5)),
    child: new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            decoration:
                BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/header.png"), fit: BoxFit.cover)),
            child: Text(""),
          ),
          new ListTile(
            title: new Text(
              "Foto de Perfil",
              style: estiloLetra,
            ),
            trailing: new Icon(
              Icons.account_circle,
              color: colorBase,
            ),
            onTap: () => Navigator.of(context).pushNamed('subirImagenes'),
          ),
          new Divider(height: 5.0, color: colorBase),
          new ListTile(
            title: new Text(
              "Documentos Personales",
              style: estiloLetra,
            ),
            trailing: new Icon(Icons.panorama, color: colorBase),
              onTap: () => Navigator.of(context).pushNamed('subirDocumentos'),
          ),
          new Divider(height: 5.0, color: colorBase),
          new ListTile(
            title: new Text(
              "Promociones",
              style: estiloLetra,
            ),
            trailing: new Icon(Icons.close, color: colorBase),
            onTap: () => Navigator.of(context).pop(),
          ),
          new Divider(
            height: 5.0,
            color: colorBase,
          ),
          new ListTile(
            title: new Text(
              "Acerca de nosotros",
              style: estiloLetra,
            ),
            trailing: new Icon(Icons.flag, color: colorBase),
            onTap: () => Navigator.of(context).pop(),
          ),
          new Divider(
            height: 5.0,
            color: colorBase,
          ),
          new ListTile(
            title: new Text(
              "Cerrar Sesion",
              style: estiloLetra,
            ),
            trailing: new Icon(Icons.exit_to_app, color: colorBase),
            onTap: () => cerrarSesion(context),
          ),
          new Divider(
            height: 5.0,
            color: colorBase,
          )
        ],
      ),
    ),
  );
}

void cerrarSesion(BuildContext context) {
  final usuServices = new UserServices();
  usuServices.signOut();
  usuServices.eliminarPreferencias();
  Navigator.pushReplacementNamed(context, "login");
}
