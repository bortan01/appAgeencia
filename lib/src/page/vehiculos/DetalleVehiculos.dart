import 'package:flutter/material.dart';

import 'package:peliculas/src/page/vehiculos/HomeCategoria.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';

class DetalleVehiculos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new CustomScrollView(
        slivers: <Widget>[
          AppBarWidget(
              titulo: "Elantra 2020",
              imagen:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQG356LIbLadfZO3JsJcNpCSwBrotB57G35xQ&usqp=CAU"),
          new SliverList(
              delegate: new SliverChildListDelegate([
            new SizedBox(
              height: 10.0,
            ),
            _posterTitulo(
                context: context,
                titulo: "Hyundai Elantra 2020",
                subtitulo: "Depósito de combustible lleno",
                imagen:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQG356LIbLadfZO3JsJcNpCSwBrotB57G35xQ&usqp=CAU",
                precio: "28.50",
                id: "1000"),
            _botones(context),
            _cuadros(),
            _adicional()
          ]))
        ],
      ),
    );
  }
}

_posterTitulo(
    {BuildContext context,
    String titulo,
    String subtitulo,
    String precio,
    String imagen,
    String id}) {
  //print(paquete.originalTitle);
  return new Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: <Widget>[
        Hero(
          child: ClipRRect(
            child: new Image(
              image: NetworkImage(imagen),
              height: 100,
              width: 125,
            ),
            borderRadius: new BorderRadius.circular(20.0),
          ),
          tag: id,
        ),
        new SizedBox(
          width: 20.0,
        ),
        new Flexible(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: new Text(
                titulo,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                overflow:
                    TextOverflow.ellipsis, //por si el titulo es muy grande
              ),
            ),
            new Text(subtitulo,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blueAccent,
                ),
                overflow: TextOverflow.ellipsis),
            new Row(
              children: <Widget>[
                new Icon(Icons.attach_money),
                new Text(
                  precio,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )
              ],
            )
          ],
        ))
      ],
    ),
  );
}

Container _botones(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    decoration: BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(35),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.call_received,
                color: Colors.white,
              ),
              Text(
                "Ver Flota de Vehiculos",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeCategoria()),
            );
          },
        ),
        Container(
          height: 30,
          width: 1,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.white54,
                width: 3.0,
              ),
            ),
          ),
        ),
        FlatButton(
          child: Row(
            children: <Widget>[
              Text(
                "Reservar",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.call_made,
                color: Colors.white,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'Alquiler');
          },
        ),
      ],
    ),
  );
}

Widget _cuadros() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(31),
        topRight: Radius.circular(31),
      ),
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyIconButton(
                buttonText: "Gasolina",
                buttonIcon: Icons.drive_eta,
              ),
              MyIconButton(
                buttonText: "Automatico",
                buttonIcon: Icons.drive_eta,
              ),
              MyIconButton(
                buttonText: "4 Puertas",
                buttonIcon: Icons.home,
              ),
              MyIconButton(
                buttonText: "5 Pasajeros",
                buttonIcon: Icons.event_seat,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _adicional() {
  return Container(
    padding: EdgeInsets.all(11.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(31),
        topRight: Radius.circular(31),
      ),
      color: Colors.grey[200],
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Adicional: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            FlatButton(
              child: Text(
                "",
                style: TextStyle(
                  color: Color(0xFF009ff7),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
        _item(
            icono: Icons.wifi,
            titulo: "Wifi",
            descripcion:
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus, enim hic."),
        _item(
            icono: Icons.volume_up,
            titulo: "Sonido",
            descripcion:
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus, enim hic."),
        _item(
            icono: Icons.toys,
            titulo: "Aire Acondicionado",
            descripcion:
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus, enim hic."),
        _item(
            icono: Icons.wifi,
            titulo: "Wifi",
            descripcion:
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus, enim hic."),
        _item(
            icono: Icons.volume_up,
            titulo: "Sonido",
            descripcion:
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus, enim hic."),
        _item(
            icono: Icons.toys,
            titulo: "Aire Acondicionado",
            descripcion:
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus, enim hic."),
      ],
    ),
  );
}

Widget _item({IconData icono, String titulo, String descripcion}) {
  return Row(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(11),
        margin: EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFF009ff7),
        ),
        child: Icon(
          icono,
          color: Colors.white,
        ),
      ),
      SizedBox(
        width: 5.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              titulo,
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              descripcion,
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ),
    ],
  );
}

class MyIconButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  const MyIconButton({Key key, this.buttonText, this.buttonIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Icon(
              buttonIcon,
              color: Color(0xFF009ff7),
            ),
          ),
          Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
