import 'package:flutter/material.dart';
import 'package:peliculas/src/models/chat/chatFirebase_model.dart';
import 'package:peliculas/src/page/chat/message_widget.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/chat_services.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({Key key}) : super(key: key);

  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> with TickerProviderStateMixin {
  PreferenciasUsuario preferencias = new PreferenciasUsuario();
  List<ChatFirebase> listaMensajes;
  Future<List<ChatFirebase>> mensajesInicialesFurute;

  @override
  void initState() {
    super.initState();
    mensajesInicialesFurute = _getMensajesIniciales();
  }

  Future<List<ChatFirebase>> _getMensajesIniciales() async {
    return await ChatServices().getMessagesFirtTime();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mensajesInicialesFurute,
      builder: (BuildContext context, AsyncSnapshot<List<ChatFirebase>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            print('activo');
            return Center(child: CircularProgressIndicator());
          case ConnectionState.waiting:
            print('esperando');
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            listaMensajes = snapshot.data;
            print(listaMensajes.length);
            return mensajeListener(listaMensajes);
          default:
            print('esperando');
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  StreamBuilder<List<ChatFirebase>> mensajeListener(List<ChatFirebase> listMensajesIniciales) {
    ChatServices chatServices = new ChatServices();
    return StreamBuilder<List<ChatFirebase>>(
      stream: chatServices.getMessagesListener(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Intente Mas tarde');
            } else {
              List<ChatFirebase> messagesNuevos = snapshot.data;
              print(listMensajesIniciales.length);
              listMensajesIniciales.insertAll(0, messagesNuevos);
              return listaMensajes.isEmpty
                  ? buildText('No hay mensajes todavía...')
                  : ListView.builder(
                      padding: new EdgeInsets.all(8.0),
                      reverse: true,
                      itemCount: listaMensajes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MessageWidget(
                          text: listaMensajes[index].message,
                          emisor: preferencias.uid == listaMensajes[index].user1Uuid,
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
