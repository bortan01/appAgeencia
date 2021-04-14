import 'package:flutter/material.dart';
import 'package:peliculas/src/page/chat/message_widget.dart';
import 'package:peliculas/src/page/chat/messages_widget.dart';
import 'package:peliculas/src/services/user_services.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen();
  @override
  _ChatScreenState createState() => new _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<MessageWidget> _messages = <MessageWidget>[];
  bool _emisorTest = true;
  bool _isTyped = false;
  UserServices userServices = new UserServices();
  Future<dynamic> dataChat;

  @override
  void initState() {
    super.initState();
  }

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
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          child: new Row(children: <Widget>[
            new Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextField(
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isTyped = (text.trim()).length > 0;
                    });
                  },
                  decoration: new InputDecoration.collapsed(hintText: "Enviar mensaje"),
                ),
              ),
            ),
            new Container(
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: _isTyped ? () => _handledSubmit(_textController.text.trim()) : null,
              ),
            )
          ]),
        ));
  }

  void _handledSubmit(String text) {
    _emisorTest = !_emisorTest;
    _textController.clear();
    setState(() {
      _isTyped = false;
    });
    MessageWidget message = new MessageWidget(
      text: text,
      emisor: _emisorTest,
      animationController: new AnimationController(duration: new Duration(milliseconds: 700), vsync: this),
      name: "Servicio al Cliente",
    );

    setState(() {
      _messages.insert(0, message);
      // var data = messageData.firstWhere((t) => t.name == widget.name);
      // data.message = message.text;
    });
    message.animationController.forward();
    print(text);
  }
}
