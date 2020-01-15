import 'package:flutter/material.dart';
import 'package:postman/app/models/media_model.dart';

class UserImageWidget extends StatelessWidget {
  final MediaModel image;
  final IconData icon;

  const UserImageWidget({
    Key key,
    this.image,
    this.icon = Icons.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (image != null && image.url != null)
        ? CircleAvatar(
            backgroundImage: NetworkImage(image.url),
          )
        : Icon(icon);
  }
}
