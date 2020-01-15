import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/modules/chat/chat_module.dart';
import 'package:postman/app/modules/contacts/contacts_module.dart';
import 'package:postman/app/modules/home/home_controller.dart';
import 'package:postman/app/modules/home/home_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeModule.to.getBloc<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${controller.user.username}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(
          builder: _builder,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openPage(
          ContactsModule(),
        ),
        child: Icon(Icons.people),
      ),
    );
  }

  Widget _builder(BuildContext context) {
    return ListView.separated(
      itemCount: controller.chatList.length,
      itemBuilder: (BuildContext context, int index) {
        controller.chatList.sort(sortChat);

        return _listTile(controller.chatList[index]);
      },
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height / 9,
        ),
        child: Divider(),
      ),
    );
  }

  int sortChat(ChatModel a, ChatModel b) {
    if (b.messages.length != 0 && a.messages.length != 0)
      return b.messages[0].sendingAt.compareTo(a.messages[0].sendingAt);
    else
      return 0;
  }

  Widget _listTile(ChatModel chat) {
    return InkWell(
      onTap: () => openPage(
        ChatModule(
          chat,
          controller.user,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          child: UserImageWidget(
            image: chat.image,
          ),
        ),
        title: Text(chat.name),
        subtitle: (chat.messages.length > 0)
            ? Text(
                '${chat.messages[0].user.username}: ${chat.messages[0].content}',
              )
            : null,
      ),
    );
  }

  openPage(pageModule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageModule,
      ),
    );
  }
}
