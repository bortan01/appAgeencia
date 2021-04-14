import 'package:flutter/material.dart';


class MessageWidget extends StatelessWidget {
  MessageWidget({this.text, this.animationController, this.name, this.emisor});
  final String text;
  final AnimationController animationController;
  final String name;
  final bool emisor;
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: (emisor) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                        color: (emisor) ? Colors.blue : Colors.grey, borderRadius: BorderRadius.circular(40.0)),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: new Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
