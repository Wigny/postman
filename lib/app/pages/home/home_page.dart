import 'package:flutter/material.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/models/user_chats_model.dart';
import 'package:postman/app/pages/contacts/contacts_module.dart';
import 'package:postman/app/pages/home/home_bloc.dart';
import 'package:postman/app/pages/home/home_module.dart';
import 'package:postman/app/pages/chat/chat_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _homeBloc = HomeModule.to.getBloc<HomeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Postman'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<UserChatsModel>>(
          stream: _homeBloc.chatListStream,
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

  Widget _builder(
    BuildContext context,
    AsyncSnapshot snapshot,
  ) {
    if (!snapshot.hasData || snapshot.data.isEmpty)
      return Center(
        child: const Text('Você não possui messagens'),
      );

    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        snapshot.data.sort(sortChat);

        return _listTile(snapshot.data[index].chat);
      },
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height / 9,
        ),
        child: Divider(),
      ),
    );
  }

  int sortChat(UserChatsModel a, UserChatsModel b) {
    if (b.chat.messages.length != 0 && a.chat.messages.length != 0)
      return b.chat.messages[0].sendingAt
          .compareTo(a.chat.messages[0].sendingAt);
    else
      return 0;
  }

  Widget _listTile(ChatModel chat) {
    return InkWell(
      onTap: () => openPage(
        ChatModule(
          chat,
          _homeBloc.user,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          child: UserImageWidget(image: chat.image),
        ),
        title: Text(chat.name),
        subtitle: (chat.messages.length != 0)
            ? RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${chat.messages[0].user.username}:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' ${chat.messages[0].content}'),
                  ],
                ),
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
