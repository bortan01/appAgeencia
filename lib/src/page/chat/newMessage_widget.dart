import 'package:flutter/material.dart';
import 'package:peliculas/src/services/chat_services.dart';

class NewMessageWidget extends StatefulWidget {
  NewMessageWidget({Key key}) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();

  bool _emisorTest = true;
  bool _isTyped = false;
  ChatServices _chatServices = new ChatServices();

  @override
  Widget build(BuildContext context) {
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
    _chatServices.addMessage(text, "RQjLWk34VddV8v2IVjNZfkwIEm33", "28TK1JZ3yWRf2DT5TzdRd5hT0L43", "00173220210413");
    print(text);
  }
}
