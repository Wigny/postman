import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  final String image;
  final IconData icon;

  const UserImageWidget({Key key, this.image, this.icon = Icons.chat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (image != null)
        ? CircleAvatar(
            backgroundImage: NetworkImage(image),
          )
        : Icon(icon);
  }
}
