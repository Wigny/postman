import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/pages/home/home_bloc.dart';
import 'package:postman/app/pages/home/home_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: Text('Olá, Tester'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<MessageModel>>(
          stream: _homeBloc.messageListFlux,
          builder: _builder,
        ),
      ),
    );
  }

  Widget _builder(
    BuildContext context,
    AsyncSnapshot<List<MessageModel>> snapshot,
  ) {
    if (!snapshot.hasData || snapshot.data.isEmpty)
      return Center(
        child: const Text('Você não possui messagens'),
      );

    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        final MessageModel message = snapshot.data[index];
        return _listTile(message);
      },
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height / 9,
        ),
        child: Divider(),
      ),
    );
  }

  Widget _listTile(MessageModel message) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");

    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(message.user.image),
        ),
        title: Text(message.user.username),
        subtitle: Text(message.content),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                dateFormat.format(message.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Badge(
                badgeContent: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                badgeColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
