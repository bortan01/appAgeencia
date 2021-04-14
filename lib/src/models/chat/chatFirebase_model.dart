// To parse this JSON data, do
//
//     final chatFirebase = chatFirebaseFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatFirebase chatFirebaseFromJson(String str) => ChatFirebase.fromJson(json.decode(str));

String chatFirebaseToJson(ChatFirebase data) => json.encode(data.toJson());

class ChatFirebase {
  ChatFirebase({
    this.chatUuid,
    this.message,
    this.time,
    this.user1IsView,
    this.user1Uuid,
    this.user2IsView,
    this.user2Uuid,
  });

  String chatUuid;
  String message;
  Timestamp time;
  int user1IsView;
  String user1Uuid;
  int user2IsView;
  String user2Uuid;

  factory ChatFirebase.fromJson(Map<String, dynamic> json) => ChatFirebase(
        chatUuid: json["chat_uuid"],
        message: json["message"],
        time: json["time"],
        user1IsView: json["user_1_isView"],
        user1Uuid: json["user_1_uuid"],
        user2IsView: json["user_2_isView"],
        user2Uuid: json["user_2_uuid"],
      );

  Map<String, dynamic> toJson() => {
        "chat_uuid": chatUuid,
        "message": message,
        "time": time,
        "user_1_isView": user1IsView,
        "user_1_uuid": user1Uuid,
        "user_2_isView": user2IsView,
        "user_2_uuid": user2Uuid,
      };


    static ChatFirebase  desdeJson(Map<String, dynamic> json) => ChatFirebase(
        chatUuid: json["chat_uuid"],
        message: json["message"],
        time: json["time"],
        user1IsView: json["user_1_isView"],
        user1Uuid: json["user_1_uuid"],
        user2IsView: json["user_2_isView"],
        user2Uuid: json["user_2_uuid"],
      );
}
