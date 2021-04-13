import 'package:flutter/material.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String name = "Servicio al Cliente";
  ChatScreen();
  @override
  _ChatScreenState createState() => new _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _emisorTest = true;
  bool _isTyped = false;
  UserServices userServices = new UserServices();

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
    ChatMessage message = new ChatMessage(
      text: text,
      emisor: _emisorTest,
      animationController: new AnimationController(duration: new Duration(milliseconds: 700), vsync: this),
      name: widget.name,
    );

    setState(() {
      _messages.insert(0, message);
      // var data = messageData.firstWhere((t) => t.name == widget.name);
      // data.message = message.text;
    });
    message.animationController.forward();
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.name),
          centerTitle: true,
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: new ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              new Divider(height: 1.0),
              new Container(
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }

  getData() async {
    FirebaseFirestore.instance
        .collection('chat')
        .where('chat_uuid', isEqualTo: '00173220210413')
        .orderBy('time', descending: true)
        .limit(9)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _handledSubmit(doc['message']);
        print(doc['message']);
      });
    });
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController, this.name, this.emisor});
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
