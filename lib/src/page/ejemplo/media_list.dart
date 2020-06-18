 import 'package:flutter/material.dart';
import 'package:peliculas/src/common/HttpHandler.dart';
import 'package:peliculas/src/models/Media.dart';
import 'media__list_item.dart';

class MediaList extends StatefulWidget {
  @override
  _MediaListState createState() => _MediaListState();


}

class _MediaListState extends State<MediaList> {
List<Media>  _media = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMovies();

  }

void loadMovies() async{
  var movies = await HttpHandler().fetchMovies();
  setState(() {
    _media.addAll(movies);
  });
}


  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
          itemBuilder:  (BuildContext context, int index ){
              return new MediaListItem(_media[index] );
          } ,
        itemCount: _media.length,
      ),
    );
  }
}
