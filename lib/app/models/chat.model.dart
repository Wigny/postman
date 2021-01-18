class ChatModel {
  ChatModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
  });

  int id;
  String title;
  dynamic description;
  DateTime createdAt;

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description == null ? null : description,
      };
}
