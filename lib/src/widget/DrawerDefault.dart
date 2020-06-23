import 'package:flutter/material.dart';

Widget getDrawerDefault(BuildContext context) {
  final colorBase =  Theme.of(context).bottomAppBarColor;
   final estiloLetra  = new TextStyle(color: colorBase); 
  return Theme(
    data: Theme.of(context).copyWith(canvasColor: Theme.of(context).accentColor.withOpacity(0.5)),
    child: new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/header.png"),
                fit: BoxFit.cover
              )
            ),
            child: Text(""),
          ),
          new ListTile(
            title: new Text("Peliculas", style: estiloLetra,),
            
            trailing: new Icon(Icons.local_movies, color:  colorBase,),
          ),
          new Divider(height: 5.0, color: colorBase),
          new ListTile(
            title: new Text("Television", style: estiloLetra,),
            trailing: new Icon(Icons.live_tv, color:  colorBase),
          ),
          new Divider(height: 5.0 , color: colorBase),
          new ListTile(
            title: new Text("Cerrar", style: estiloLetra,),
            trailing: new Icon(Icons.close, color:  colorBase),
            onTap: () => Navigator.of(context).pop(),
          ),
          new Divider(height: 5.0,  color: colorBase,)
        ],
      ),
    ),
  );
}
