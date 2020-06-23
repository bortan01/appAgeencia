import 'dart:math';

import 'package:flutter/material.dart';


var COLORS = [
  Color(0xFF6c8ac8),
  Color(0xFF00f7aa),
  Color(0xFF5eb146),
  Color(0xFF009ff7),
  Color(0xFFB892FF)
];

class HomeCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
           
      body: new MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = [
    {
      "title": "Sedan",
      "content": "Espacio, seguridad y rendimiento es la fórmula de un sedán.",
      "color": COLORS[new Random().nextInt(5)],
      "image": "http://universalrentaautos.com/fotos/nissan-versa-2016-blanco.jpg"
    },
    {
      "title": "Camionetas",
      "content": "Mayor comodidad en viajes largos para ti y tú familia",
      "color": COLORS[new Random().nextInt(5)],
      "image": "http://universalrentaautos.com/fotos/ford_escape_2009.jpg"
    },
    {
      "title": "PickUp",
      "content": "Resistencia, capacidad de trabajo y adaptabilidad.",
      "color": COLORS[new Random().nextInt(5)],
      "image": "http://universalrentaautos.com/fotos/mitsubish_l20014.jpg"
    },
    {
      "title": "Microbuses",
      "content": "Excelente visibilidad además de una carrocería con zonas que absorben la colisión o aplastamiento.",
      "color": COLORS[new Random().nextInt(5)],
      "image": "http://universalrentaautos.com/fotos/hiunday-h1-tq-2013-blanca.jpg"
    },
    {
      "title": "Minivans",
      "content": "Para personas mayores o con discapacidad, una minivan puede ser más fácil de abordar y más cómoda al subir, al salir y al moverse en el interior.",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://realrentcar.com.sv/files/vehiculos/129/129-1.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: new Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Transform.translate(
            offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
            child: new ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              scrollDirection: Axis.vertical,
              primary: true,
              itemCount: data.length,
              itemBuilder: (BuildContext content, int index) {
                return GestureDetector(
                      onTap: (){  Navigator.pushNamed(context, 'HomePaquetes');},
                      child: AwesomeListItem(
                      title: data[index]["title"],
                      content: data[index]["content"],
                      color: data[index]["color"],
                      image: data[index]["image"]),
                );
              },
            ),
          ),

          new Transform.translate(
            offset: Offset(0.0, -56.0),
            child: new Container(
              child: new ClipPath(
                clipper: new MyClipper(),
                child: new Stack(
                  children: [
                    new Image.network(
                      "https://static.rentcars.com/landing-page/aws-s3-807e715031bd5798798ba7d0ad87e584.png",
                      fit: BoxFit.cover,
                    ),
                    new Opacity(
                      opacity: 0.2,
                      child: new Container(color: COLORS[0]),
                    ),
                    new Transform.translate(
                      offset: Offset(0.0, 60.0),
                      child: new ListTile(
                        
                        title: new Text(
                          "",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              letterSpacing: 2.0),
                        ),
                        subtitle: new Text(
                          "",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class AwesomeListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;

  AwesomeListItem({this.title, this.content, this.color, this.image});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(width: 10.0, height: 190.0, color: widget.color),
        new Expanded(
          child: new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: new Text(
                    widget.content,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        new Container(
          height: 150.0,
          width: 150.0,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              new Transform.translate(
                offset: new Offset(50.0, 0.0),
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  color: widget.color,
                ),
              ),
              new Transform.translate(
                offset: Offset(10.0, 20.0),
                child: new Card(
                  elevation: 20.0,
                  child: new Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 10.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}