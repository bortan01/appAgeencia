import 'package:flutter/material.dart';

import 'Chats.dart';




class WhatsAppHome extends StatefulWidget {
  @override
  _WhatsAppHomeState createState() => new _WhatsAppHomeState();
}
/// ///////////////////////////////////////////////////////////////////////////////////
class _WhatsAppHomeState extends State<WhatsAppHome> with SingleTickerProviderStateMixin   {
 ///recordar estender de SingleTickerProviderStateMixin

  TabController _tabController;
 
 @override
  void initState() {
    // TODO: implementInitState
    super.initState();
    _tabController = new TabController(length: 4 , vsync:this, initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Chat"),
      ),
      body:
       
        new Chats(),
      

    );
  }
}
