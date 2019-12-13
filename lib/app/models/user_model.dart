class UserModel {
  int id;
  String nickname;
  String username;
  String image;

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
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "username": username,
        "image": image,
      };
}
