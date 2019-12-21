import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  final String image;

  const UserImageWidget({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (image != null)
        ? CircleAvatar(
            backgroundImage: NetworkImage(image),
          )
        : Icon(Icons.chat);
  }
}
