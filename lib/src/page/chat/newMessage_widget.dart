import 'package:flutter/material.dart';
import 'package:peliculas/src/page/chat/message_widget.dart';


class NewMessageWidget extends StatefulWidget {
  NewMessageWidget({Key key}) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> with TickerProviderStateMixin {

    final TextEditingController _textController = new TextEditingController();

  bool _emisorTest = true;
  bool _isTyped = false;
  
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
    MessageWidget message = new MessageWidget(
      text: text,
      emisor: _emisorTest,
      animationController: new AnimationController(duration: new Duration(milliseconds: 700), vsync: this),
      name: "Servicio al Cliente",
    );

  
    message.animationController.forward();
    print(text);
  }

}