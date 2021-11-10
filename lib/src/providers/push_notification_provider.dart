import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';


//cg7jHTZxRmuLoLePCmVfR3:APA91bEaEaN0fw_iWrphfXd9uk1JcyIYBk0k3XAqh4ESLOKmzRmFCPx5umvhRKlsy4URu0n13ft_fyPI_cBoqTfxY7WNe9No69bz9ANvrVEjnU_dmrVsaLPGbuhQ3oYfwVPaUISHAChX
class PushNotificationProvider {
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajeStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStreams => _mensajeStreamController.stream;

  dispose() {
    _mensajeStreamController?.close();
  }

  static Future<dynamic> mensajeBackground(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  iniciarNotificaciones() async {
   
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print("====on message====");
    String argumento = "no-data";
    if (Platform.isAndroid) {
      argumento = message['data']['ruta'] ?? "no-data";
    }
    print(message);
    _mensajeStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print("====on Launch====");

    final argumento = message['data']['ruta'];
    _mensajeStreamController.sink.add(argumento);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print("====on Resume====");
    final argumento = message['data']['ruta'];
    _mensajeStreamController.sink.add(argumento);
  }
}
