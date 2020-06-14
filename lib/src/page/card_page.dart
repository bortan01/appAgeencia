import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          _cardTipo1(),
          new SizedBox(height: 20.0),
          _cardTipo2()
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("soy el titulo"),
            subtitle: new Text("soy el sub titulo"),
            leading: Icon(
              Icons.photo_album,
              color: Colors.greenAccent,
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new FlatButton(
                  padding: const EdgeInsets.all(15.0),
                  onPressed: () {},
                  child: new Text("Ok")),
              new FlatButton(
                  onPressed: () {},
                  child: new Text("Cancelar"),
                  padding: const EdgeInsets.all(15.0)),
            ],
          )
        ],
      ),
    );
  }

  Widget _cardTipo2() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blue,
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(2, 4))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          child: Column(
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(
                    'https://i.ytimg.com/vi/c7oV1T2j5mc/maxresdefault.jpg'),
                placeholder: AssetImage('assets/gif/loading.gif'),
                fadeInDuration: new Duration(milliseconds: 400),
              ),
              Container(
                  padding: const EdgeInsets.all(20.0),
                  child: new Text("no tengo idea", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20.0) )),
            ],
          ),
        ),
      ),
    );
  }
}
