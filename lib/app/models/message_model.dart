import 'dart:convert';

import 'package:postman/app/models/user_model.dart';

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(
    json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  int id;
  String content;
  int userId;
  int chatId;
  DateTime sendingAt;
  UserModel user;

  MessageModel({
    this.content,
    this.sendingAt,
    this.user,
    this.id,
    this.userId,
    this.chatId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        content: json["content"] == null ? null : json["content"],
        sendingAt: json["sending_at"] == null
            ? null
            : DateTime.parse(json["sending_at"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        chatId: json["chat_id"] == null ? null : json["chat_id"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    if (content != null) json['content'] = content;
    if (sendingAt != null) json['sending_at'] = sendingAt;
    if (user != null) json['user'] = user;
    if (id != null) json['id'] = id;
    if (userId != null) json['user_id'] = userId;
    if (chatId != null) json['chat_id'] = chatId;

    return json;
  }

}