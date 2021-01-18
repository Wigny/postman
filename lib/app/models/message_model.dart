import 'package:postman/app/models/user_model.dart';

class MessageModel {
  MessageModel({
    this.id,
    this.text,
    this.createdAt,
    this.user,
    this.chatId,
  });

  int id;
  String text;
  DateTime createdAt;
  UserModel user;
  int chatId;

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        text: json["text"],
        createdAt: DateTime.parse(json["created_at"]),
        user: UserModel.fromMap(json["user"]),
        chatId: json["chat_id"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "user_id": user.id,
        "chat_id": chatId,
      };
}
