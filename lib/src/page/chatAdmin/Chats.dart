import 'package:flutter/material.dart';
import 'package:peliculas/src/models/ChatModel.dart';

import 'ChatScreenA.dart';


class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

/// ===================================================================
class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: messageDAta.length,
      itemBuilder: (context, i) => new Column(
          children: <Widget>[
          new Divider(height: 10.0),
          new ListTile(
            leading: new CircleAvatar(
              backgroundImage: NetworkImage(messageDAta[i].imageUrl),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(messageDAta[i].name,
                    style: new TextStyle(fontWeight: FontWeight.bold)),
                new Text(messageDAta[i].time,
                    style: new TextStyle(color: Colors.grey, fontSize: 14.0))
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(messageDAta[i].message,
                  style: new TextStyle(color: Colors.grey, fontSize: 15.0)),
            ),
            onTap: () {
              var route = MaterialPageRoute(
                  builder: (BuildContext cotext) => new ChatScreenA( name: messageDAta[i].name));
              Navigator.of(context).push(route);
            },
          )
        ],
      ),
    );
  }
}
