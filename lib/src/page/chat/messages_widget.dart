import 'package:flutter/material.dart';
import 'package:peliculas/src/models/chat/chatFirebase_model.dart';
import 'package:peliculas/src/page/chat/message_widget.dart';
import 'package:peliculas/src/services/chat_services.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({Key key}) : super(key: key);

  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ChatServices chatServices = new ChatServices();
    return StreamBuilder<List<ChatFirebase>>(
      stream: chatServices.getMessages(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              List<ChatFirebase> messages = snapshot.data;

              return messages.isEmpty
                  ? buildText('Say Hi..')
                  : ListView.builder(
                      padding: new EdgeInsets.all(8.0),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(messages[index].message);

                        return MessageWidget(
                          text: messages[index].message,
                          emisor: true,
                          animationController:
                              new AnimationController(duration: new Duration(milliseconds: 700), vsync: this),
                          name: "Servicio al Cliente",
                        );
              
                      });
            }
        }
      },
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
