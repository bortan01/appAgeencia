import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peliculas/src/models/chat/chatFirebase_model.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class ChatServices {
  Stream<List<ChatFirebase>> getMessages() {
    return FirebaseFirestore.instance
        .collection('chat')
        .where('chat_uuid', isEqualTo: '00173220210413')
        .orderBy('time', descending: true)
        .limit(9)
        .snapshots()
        .transform(helper.transformer(ChatFirebase.desdeJson));
  }
}
