import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peliculas/src/models/chat/chatFirebase_model.dart';
import 'package:peliculas/src/models/chat/informacionChat_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/conf.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;
import 'package:http/http.dart' as http;

class ChatServices {
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  //LA PRIMERA VEZ QUE SE CONSTRULLE LOS MENSAJES
  Future<List<ChatFirebase>> getMessagesFirtTime() async {
    await obtenerUID();
    if (_pref.uidChat == null) return null;
    List<ChatFirebase> listaChats = [];
    final instance = FirebaseFirestore.instance
        .collection('chat')
        .where('chat_uuid', isEqualTo: _pref.uidChat)
        .orderBy('time', descending: true)
        .limit(20);

    await instance.get().then((QuerySnapshot querySnapshot) async {
      querySnapshot.docs.forEach((doc) {
        listaChats.add(new ChatFirebase(
            chatUuid: doc['chat_uuid'],
            message: doc['message'],
            user1Uuid: doc['user_1_uuid'],
            user2Uuid: doc['user_2_uuid']));
      });
    });

    return listaChats;
  }

  //ESTA FUNCION SERA ACTIVADA CUANDO SE ENVIE UN NUEVO MENSAJE
  Stream<List<ChatFirebase>> getMessagesListener() {
    return FirebaseFirestore.instance
        .collection('chat')
        .where('chat_uuid', isEqualTo: _pref.uidChat)
        .orderBy('time', descending: true)
        .limit(1)
        .snapshots()
        .transform(helper.transformer(ChatFirebase.desdeJson));
  }

  Future<void> addMessage(String message) {
    // Call the user's CollectionReference to add a new user
    CollectionReference chatreference = FirebaseFirestore.instance.collection('chat');
    return chatreference
        .add({
          "message": message,
          "user_1_uuid": _pref.uid,
          "user_2_uuid": _pref.uidAdministrador,
          "chat_uuid": _pref.uidChat,
          "user_1_isView": 0,
          "user_2_isView": 0,
          "time": new DateTime.now(),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> obtenerUID() async {
    final url = '${Conf.urlServidor}Usuario/obtenerChat';
    final response = await http.post(url, body: {"user_2": _pref.uid},headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    if (response.statusCode == 200) {
      final infoChat = informacionChatModelFromJson(response.body);
      _pref.uidAdministrador = infoChat.user1Uuid;
      _pref.uidChat = infoChat.chatUuid;
    }
  }
}
