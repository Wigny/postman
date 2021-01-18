import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:postman/app/models/chat.model.dart';
import 'package:postman/app/modules/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Postman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: controller.chats,
          builder: builder,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addChat,
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }

  Widget builder(
    BuildContext context,
    AsyncSnapshot snapshot,
  ) {
    if (!snapshot.hasData)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (snapshot.data.isEmpty)
      return Chip(
        label: Text('Você não possui conversas'),
      );

    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) => chat(
        snapshot.data[index],
      ),
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height / 9,
        ),
        child: Divider(),
      ),
    );
  }

  Widget chat(ChatModel chat) {
    return ListTile(
      leading: Icon(Icons.chat_bubble),
      title: Text(chat.title),
      subtitle: chat.description != null ? Text(chat.description) : null,
      onTap: () => Modular.navigator.pushNamed(
        '/chats/${chat.id}',
        arguments: chat,
      ),
    );
  }
}
