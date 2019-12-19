// To parse this JSON data, do
//
//     final userChatsModel = userChatsModelFromJson(jsonString);

import 'dart:convert';

import 'package:postman/app/models/chat_model.dart';

List<UserChatsModel> userChatsModelFromJson(String str) =>
    List<UserChatsModel>.from(
        json.decode(str).map((x) => UserChatsModel.fromJson(x)));

String userChatsModelToJson(List<UserChatsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserChatsModel {
  ChatModel chat;

  UserChatsModel({
    this.chat,
  });

  factory UserChatsModel.fromJson(Map<String, dynamic> json) => UserChatsModel(
        chat: ChatModel.fromJson(json["chat"]),
      );

  Map<String, dynamic> toJson() => {
        "chat": chat.toJson(),
      };
}
