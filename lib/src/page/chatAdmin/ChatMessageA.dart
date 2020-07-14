import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessageA extends StatelessWidget {
  final String text;
  final animationController;
  final String name;

  ChatMessageA({this.text, this.animationController, this.name});

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new CircleAvatar(child: new Text(name[0])),
              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            ),
            new Expanded(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(name, style: Theme.of(context).textTheme.subtitle1),
                new Container(
                  child: new Text(text),
                  margin: const EdgeInsets.only(top: 5.0),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
