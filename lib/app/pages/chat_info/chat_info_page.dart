import 'package:flutter/material.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/pages/chat_info/chat_info_bloc.dart';
import 'package:postman/app/pages/chat_info/chat_info_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class ChatInfoPage extends StatefulWidget {
  final String title;
  const ChatInfoPage({Key key, this.title = "ChatInfo"}) : super(key: key);

  @override
  _ChatInfoPageState createState() => _ChatInfoPageState();
}

class _ChatInfoPageState extends State<ChatInfoPage> {
  final bloc = ChatInfoModule.to.bloc<ChatInfoBloc>();

  @override
  Widget build(BuildContext context) {
    print(bloc.chat.image);
    print(bloc.chat.name);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(bloc.chat.name),
              background: (bloc.chat.image != null)
                  ? Image.network(
                      bloc.chat.image.url,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: (bloc.chat.description != null)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Descrição',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(
                              bloc.chat.description,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      : Text('Adicionar descrição ao grupo'),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 10,
                ),
                ListTile(
                  title: Text(
                    'Participantes',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                // ListTile(
                //   leading: Container(
                //     width: 50,
                //     height: 50,
                //     child: Icon(
                //       Icons.person_add,
                //     ),
                //   ),
                //   title: Text('Adicionar participantes'),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Divider(),
                // ),
                StreamBuilder<List<UserModel>>(
                  stream: bloc.userListStream,
                  builder: _builder,
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.red[800],
                  ),
                  title: Text(
                    'Sair do grupo',
                    style: TextStyle(
                      color: Colors.red[800],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _builder(context, snapshot) {
    if (!snapshot.hasData || snapshot.data.isEmpty)
      return Padding(
        padding: const EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      );

    return ListView.builder(
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) =>
          _user(snapshot.data[index]),
    );
  }

  Widget _user(UserModel user) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        child: UserImageWidget(
          image: user.image,
          icon: Icons.person,
        ),
      ),
      title: Text(user.username),
    );
  }
}
