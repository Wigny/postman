import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/pages/chat/chat_bloc.dart';
import 'package:postman/app/pages/chat/chat_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({Key key, this.title = "Chat"}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final bloc = ChatModule.to.bloc<ChatBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            UserImageWidget(image: bloc.chat.image),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(bloc.chat.name),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffebebeb),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: bloc.messageListStream,
              builder: _builder,
            ),
          ),
          _input(),
        ],
      ),
    );
  }

  Widget _input() {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
    );

    return Container(
      height: 65,
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: "Digite uma mensagem",
          filled: true,
          fillColor: Colors.white,
          focusedBorder: border,
          enabledBorder: border,
        ),
        autofocus: false,
        textInputAction: TextInputAction.search,
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

    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return _message(
          snapshot.data[index],
        );
      },
    );
  }

  Widget _message(MessageModel message) {
    var alignment = Alignment.centerLeft;
    var color = Colors.white;
    var crossAxisAlignment = CrossAxisAlignment.start;

    bool itsMe = message.user.id == bloc.user.id;

    if (itsMe) {
      alignment = Alignment.centerRight;
      color = Color(0xffe5ffcc);
      crossAxisAlignment = CrossAxisAlignment.end;
    }

    return Container(
      alignment: alignment,
      child: Card(
        color: color,
        child: Container(
          width: MediaQuery.of(context).size.width * .75,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: <Widget>[
                Visibility(
                  visible: !itsMe,
                  child: Text(
                    message.user.username,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Text(
                  message.content,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    formatDate(message.sendingAt),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) => DateFormat.jm().format(date.toLocal());
}
