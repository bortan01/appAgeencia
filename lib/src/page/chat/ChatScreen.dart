import 'package:peliculas/src/models/ChatModel.dart';
import 'package:flutter/material.dart';

import 'package:peliculas/src/page/chat/ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  final String name = '';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

/// ============================================================================================
class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isTyped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: new Text('Agencia de viajes'),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                  child: new ListView.builder(
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
                reverse: true,
              )),
              new Divider(height: 1.0),
              new Container(
                // color: Colors.blueAccent,
                child: _bilderTextComposer(),
              )
            ],
          ),
        ));
  }

  Widget _bilderTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          child: new Row(
            children: <Widget>[
              new Flexible(
                  child: new TextField(
                controller: _textController,
                onChanged: (String t) {
                  setState(() {
                    _isTyped = t.length > 0;
                  });
                },
                decoration:
                    new InputDecoration.collapsed(hintText: "Enviar mensaje"),
              )),
              new Container(
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: _isTyped
                        ? () => _handeleSubmit(_textController.text)
                        : null),
              )
            ],
          ),
        ));
  }

  _handeleSubmit(String text) {
    _textController.clear();
    _isTyped = false;
    ChatMessage message = new ChatMessage(
        name: widget.name,
        text: text,
        animationController: new AnimationController(
            vsync: this, duration: new Duration(milliseconds: 700)));

    setState(() {
      _messages.insert(0, message);
      var data = messageDAta.firstWhere((t) => t.name == widget.name);
      data.message = message.text;
    });
    message.animationController.forward();
  }
}
