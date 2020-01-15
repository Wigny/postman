import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/modules/contacts/contacts_controller.dart';
import 'package:postman/app/modules/contacts/contacts_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class ContactsPage extends StatefulWidget {
  final String title;
  const ContactsPage({Key key, this.title = "Contacts"}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final controller = ContactsModule.to.getBloc<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (BuildContext context) => ListView.builder(
          itemCount: controller.userList.length,
          itemBuilder: (BuildContext context, int index) => _listTile(
            controller.userList[index],
          ),
        ),
      ),
    );
  }

  Widget _listTile(UserModel user) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        child: UserImageWidget(
          image: user.image,
        ),
      ),
      title: Text(user.username),
    );
  }
}
