class MessageModel {
  int id;
  String content;
  int receptor;
  int emissor;
  DateTime createdAt;

  MessageModel({
    this.id,
    this.content,
    this.receptor,
    this.emissor,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        content: json["content"],
        receptor: json["receptor"],
        emissor: json["emissor"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "receptor": receptor,
        "emissor": emissor,
        "createdAt": createdAt.toIso8601String(),
      };
}
