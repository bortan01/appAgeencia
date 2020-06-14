import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('page Avatar'),
        actions: <Widget>[
          Container(
            child: CircleAvatar(
              child: new Text("Bo"),
              backgroundColor: Colors.yellow,
            ),
            padding: const EdgeInsets.all(0.0),

          ),
          Container(
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTT-YVdmuWcONTGazTJ0xIzM7moLhyOnN5hNCaph5wOS6JTpkKT'),
              radius: 25.0,

            ),
            padding: const EdgeInsets.all( 0.0),

          )
        ],
      ),
      body: new Center(
        child: FadeInImage(
          image: NetworkImage('https://pm1.narvii.com/6540/01bb6553dc5e51b01d7fe7847d9e3d9492fd894b_00.jpg'),
          placeholder:  AssetImage('assets/gif/loading.gif' ),
          fadeInDuration: new Duration(milliseconds: 3000),
        ),
      ),
    );
  }
}
