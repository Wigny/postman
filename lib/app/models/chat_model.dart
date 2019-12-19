// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

import 'package:postman/app/models/message_model.dart';

List<ChatModel> chatModelFromJson(String str) =>
    List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModel {
  int id;
  String name;
  String description;
  String image;
  List<MessageModel> messages;

  ChatModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        messages: json["messages"] == null
            ? null
            : List<MessageModel>.from(
                json["messages"].map(
                  (x) => MessageModel.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
        "messages": messages == null
            ? null
            : List<dynamic>.from(
                messages.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}
