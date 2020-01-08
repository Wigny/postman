// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:postman/app/models/media_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String nickname;
  String username;
  MediaModel image;

  UserModel({
    this.id,
    this.nickname,
    this.username,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nickname: json["nickname"],
        username: json["username"],
        image:
            json["image"] == null ? null : MediaModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "username": username,
        "image": image == null ? null : image.toJson(),
      };
}
