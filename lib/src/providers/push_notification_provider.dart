import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

//dVPpP65klCc:APA91bE89sOevN-Bxy4jVRXKwwkUrfAONFGL0xFeQA_R86hoem_OZaGQUVwB7LzEIzxE-M93cNksD32kueKyqxq0Hf8tHcHOnPXGqAa000Wj8V5PxCxXJwdq4THs5bFMOF2ERzzcarm0
//eAArxu_cSFqgwWetIMn4vn:APA91bEFfBUTIPg407NVDvoYDBM-QTsYBfVtUn5swL2fM1lbYiWRjXF9PdQeO0ArTvvb9xVP8vmJcKp4wG0Y0GTmpwRDMHKone9mcyUG13hZGYLrGWsD1l54WVZ8iOF7YkZz4dGYO_sA
class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();
    print("el token es $token");

//    await _firebaseMessaging.subscribeToTopic("TODOS_LOS_ANDROID");

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: mensajeBackground,
      onLaunch: onLaunch,
      onResume: onResume,
    );
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
