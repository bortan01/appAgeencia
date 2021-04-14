import 'package:flutter/material.dart';
import 'package:peliculas/src/models/chat/chatFirebase_model.dart';
import 'package:peliculas/src/services/chat_services.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({Key key}) : super(key: key);

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
                        return Container(
                          child: new Text("desde acaaa"),
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
