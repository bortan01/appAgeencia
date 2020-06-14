import 'dart:math';

import 'package:flutter/material.dart';

class AnimateContarinerPage extends StatefulWidget {
  @override
  _AnimateContarinerPageState createState() => _AnimateContarinerPageState();
}

class _AnimateContarinerPageState extends State<AnimateContarinerPage> {
  double _width =50.0;
  double _height =50.0;
  Color  _color = Colors.red;
  BorderRadiusGeometry _borderRadiusGeometry = new BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("animate Container"),


      ),
      body: new Center(
        child: new AnimatedContainer(
          width: _width,
          height: _height,
          decoration: new BoxDecoration(
            borderRadius: _borderRadiusGeometry,
            color: _color,

          ),
          duration: new Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: _cambioPropiedad,
        child: new Icon(Icons.play_circle_filled),
      ),
    );
  }

  void _cambioPropiedad() {
    final random = Random();

    setState(() {
      _height = random.nextInt(300).toDouble();
      _width = random.nextInt(300).toDouble();
      _color = Color.fromARGB(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
      
      
      _borderRadiusGeometry = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }
}
