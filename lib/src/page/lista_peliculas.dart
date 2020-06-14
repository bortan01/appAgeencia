 import 'package:flutter/material.dart';
import 'package:peliculas/src/common/HttpHandler.dart';
import 'package:peliculas/src/page/media_list.dart';

class ListaPeliculas extends StatefulWidget {
  @override
  _ListaPeliculas createState() => _ListaPeliculas();
}

class _ListaPeliculas extends State<ListaPeliculas> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Movie"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search,  color: Colors.white),
             onPressed: null)
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(child: new Material()),
            new ListTile(
              title: new Text("Peliculas"),
              trailing: new Icon(Icons.local_movies),
            ),
            new Divider(height: 5.0 ),
            new ListTile(
              title: new Text("Television"),
              trailing: new Icon(Icons.live_tv),
            ),
            new Divider(height: 5.0 ),
            new ListTile(
              title: new Text("Cerrar"),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
            new Divider(height: 5.0 )
          ],
        ),
      ),
      body: new PageView(
        children: <Widget>[
          new MediaList(

          )
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
          items: _getFooterItems(),
      ),
    );
  }

 List<BottomNavigationBarItem>  _getFooterItems() {
    return [
      new BottomNavigationBarItem(
          icon: new Icon(Icons.thumb_up),
        title: new Text("Populares")
      ),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.update),
          title: new Text("Proximamente")
      ),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.star),
          title: new Text("Mejor Valoradas")
      ),


    ];
 }

  loadMovies () async {
    var movies = await HttpHandler().fetchMovies();
    setState(() {

    });
  }


}
