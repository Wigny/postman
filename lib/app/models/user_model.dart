class UserModel {
  UserModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "id": id == null ? null : id,
      };
}
