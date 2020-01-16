import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/modules/chat_info/chat_info_controller.dart';
import 'package:postman/app/modules/chat_info/chat_info_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class ChatInfoPage extends StatefulWidget {
  final String title;
  const ChatInfoPage({Key key, this.title = "ChatInfo"}) : super(key: key);

  @override
  _ChatInfoPageState createState() => _ChatInfoPageState();
}

class _ChatInfoPageState extends State<ChatInfoPage> {
  final controller = ChatInfoModule.to.getBloc<ChatInfoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(controller.chat.name),
              background: (controller.chat.image != null)
                  ? Image.network(
                      controller.chat.image.url,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: (controller.chat.description != null)
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
                              controller.chat.description,
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
                Observer(
                  builder: (BuildContext context) => ListView.builder(
                    padding: EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.userList.length,
                    itemBuilder: (BuildContext context, int index) => _user(
                      controller.userList[index],
                    ),
                  ),
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
