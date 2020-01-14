// To parse this JSON data, do
//
//     final mediaModel = mediaModelFromJson(jsonString);

import 'dart:convert';

MediaModel mediaModelFromJson(String str) =>
    MediaModel.fromJson(json.decode(str));

String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel {
  int id;
  String filename;
  String mimetype;
  String url;

  MediaModel({
    this.id,
    this.filename,
    this.mimetype,
    this.url,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        id: json["id"],
        filename: json["filename"],
        mimetype: json["mimetype"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "data": {
          "filename": filename,
          "mimetype": mimetype,
          "url": url,
        },
      };
}
