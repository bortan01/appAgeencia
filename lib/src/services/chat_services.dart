import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peliculas/src/models/chat/chatFirebase_model.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class ChatServices {
  //LA PRIMERA VEZ QUE SE CONSTRULLE LOS MENSAJES
  Future<List<ChatFirebase>> getMessagesFirtTime() async {
    List<ChatFirebase> listaChats = [];

    FirebaseFirestore.instance
        .collection('chat')
        .where('chat_uuid', isEqualTo: '00173220210413')
        .orderBy('time', descending: true)
        .limit(9)
        .get()
        .then((QuerySnapshot querySnapshot) {
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
        .where('chat_uuid', isEqualTo: '00173220210413')
        .orderBy('time', descending: true)
        .limit(1)
        .snapshots()
        .transform(helper.transformer(ChatFirebase.desdeJson));
  }

  Future<void> addMessage(String message, String user1, String user2, String uuid) {
    // Call the user's CollectionReference to add a new user
    CollectionReference chatreference = FirebaseFirestore.instance.collection('chat');
    return chatreference
        .add({
          "message": message,
          "user_1_uuid": user1,
          "user_2_uuid": user2,
          "chat_uuid": uuid,
          "user_1_isView": 0,
          "user_2_isView": 0,
          "time": new DateTime.now(),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
