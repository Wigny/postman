// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'package:postman/app/models/user_model.dart';

class MessageModel {
  int id;
  String content;
  int receptor;
  UserModel user;
  DateTime createdAt;

  MessageModel({
    this.id,
    this.content,
    this.receptor,
    this.user,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        content: json["content"],
        receptor: json["receptor"],
        user: UserModel.fromJson(json["user"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "receptor": receptor,
        "user": user.toJson(),
        "createdAt": createdAt.toIso8601String(),
      };

  static List<MessageModel> fromJsonList(List list) {
    if (list == null) return null;
    return list
        .map<MessageModel>(
          (item) => MessageModel.fromJson(item),
        )
        .toList();
  }
}
