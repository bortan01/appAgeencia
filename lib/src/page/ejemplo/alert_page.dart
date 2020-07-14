import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('page aleert'),
      ),
      body: new Center(
          child: new RaisedButton(
        onPressed: () => mostrarAlerta(context),
        child: new Text("Mostrar Alerta"),
        color: Colors.blueAccent,
        textColor: Colors.white,
        shape: new StadiumBorder(),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  mostrarAlerta(BuildContext context) {
//    rootBundle.loadString('http://www.christianmeza.com/api/index.php')
//        .then((data){
//      print(data);
//
//    });

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            title: new Text("titulo"),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text("Este es el contenido de la cjaja de la alerta"),
                new FlutterLogo(
                  size: 100.0,
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("cancelar"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text("ok"))
            ],
          );

          ///
        });
  }
}
