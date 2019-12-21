import 'package:flutter/material.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/pages/contacts/contacts_bloc.dart';
import 'package:postman/app/pages/contacts/contacts_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class ContactsPage extends StatefulWidget {
  final String title;
  const ContactsPage({Key key, this.title = "Contacts"}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = ContactsModule.to.bloc<ContactsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: _bloc.userListFlux,
        initialData: [],
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, snapshot) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return _listTile(snapshot.data[index]);
      },
    );
  }

  Widget _listTile(UserModel user) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        child: UserImageWidget(
          image: user.image
        ),
      ),
      title: Text(user.username),
    );
  }
}
