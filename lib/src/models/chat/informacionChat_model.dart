// To parse this JSON data, do
//
//     final informacionChatModel = informacionChatModelFromJson(jsonString);

import 'dart:convert';

InformacionChatModel informacionChatModelFromJson(String str) => InformacionChatModel.fromJson(json.decode(str));

String informacionChatModelToJson(InformacionChatModel data) => json.encode(data.toJson());

class InformacionChatModel {
    InformacionChatModel({
        this.user1Uuid,
        this.user2Uuid,
        this.chatUuid,
    });

    String user1Uuid;
    String user2Uuid;
    String chatUuid;

    factory InformacionChatModel.fromJson(Map<String, dynamic> json) => InformacionChatModel(
        user1Uuid: json["user_1_uuid"],
        user2Uuid: json["user_2_uuid"],
        chatUuid: json["chat_uuid"],
    );

    Map<String, dynamic> toJson() => {
        "user_1_uuid": user1Uuid,
        "user_2_uuid": user2Uuid,
        "chat_uuid": chatUuid,
    };
}
