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
  MediaModel avatar;

  UserModel({
    this.id,
    this.nickname,
    this.username,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nickname: json["nickname"],
        username: json["username"],
        avatar:
            json["avatar"] == null ? null : MediaModel.fromJson(json["avatar"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "username": username,
        "avatar": avatar == null ? null : avatar.toJson(),
      };
}
