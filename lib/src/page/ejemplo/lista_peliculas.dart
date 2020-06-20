import 'package:flutter/material.dart';
import 'package:peliculas/src/common/HttpHandler.dart';
import 'package:peliculas/src/page/ejemplo/media_list.dart';
import 'package:peliculas/src/widget/drawerDefault.dart';
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
      drawer: getDrawerDefault(context),
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
