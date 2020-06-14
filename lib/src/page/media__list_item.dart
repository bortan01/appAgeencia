import 'package:flutter/material.dart';
import 'package:peliculas/src/models/Media.dart';

class MediaListItem extends StatelessWidget {
  final Media media;

  MediaListItem(this.media);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new Column(
        children: <Widget>[
          new Container(
            child: Stack(
              children: <Widget>[
                new FadeInImage.assetNetwork(
                  placeholder: "assets/gif/loading.gif",
                  image: media.getBackDropUrl(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  fadeInDuration: new Duration(milliseconds: 40),
                  height: 200.0,
                ),
                new Positioned(
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: Colors.grey[900].withOpacity(0.5),
                      ),
                      constraints: new BoxConstraints.expand(
                        height: 55.0
                      ),
                    ),
                  left: 0.0,
                  bottom: 0.0,
                  right: 0.0
                )  ,
                new Positioned(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                   children: <Widget>[
                     new Container(
                       child: new Text(media.title, style: new TextStyle(fontWeight: FontWeight.bold)),
                     )
                   ],
                  ),
                  left: 10.0,
                  bottom: 30.0,

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
