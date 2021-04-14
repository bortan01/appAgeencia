import 'package:flutter/material.dart';
import 'package:peliculas/src/page/chat/messages_widget.dart';
import 'package:peliculas/src/page/chat/newMessage_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen();
  @override
  _ChatScreenState createState() => new _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Servicio al Cliente"),
          centerTitle: true,
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: MessagesWidget(),
              ),
              new Divider(height: 1.0),
              new Container(
                child: NewMessageWidget(),
              )
            ],
          ),
        ));
  }
}
