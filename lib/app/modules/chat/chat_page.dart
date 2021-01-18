import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postman/app/models/chat.model.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/modules/chat/chat_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chat;
  const ChatPage({Key key, this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: controller.messages,
              builder: builder,
            ),
          ),
          input(),
        ],
      ),
    );
  }

  Widget input() {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
    );

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                controller: controller.textController,
                decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Digite uma mensagem",
                  filled: true,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                autofocus: false,
                textInputAction: TextInputAction.send,
                onSubmitted: controller.submit,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: FloatingActionButton(
              child: Icon(Icons.send),
              elevation: 0,
              onPressed: controller.submit,
            ),
          ),
        ],
      ),
    );
  }

  Widget builder(
    BuildContext context,
    AsyncSnapshot<List<MessageModel>> snapshot,
  ) {
    if (!snapshot.hasData)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (snapshot.data.isEmpty)
      return Chip(
        label: Text('Não há messagens'),
      );

    return ListView.builder(
      padding: EdgeInsets.all(8),
      reverse: true,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) => message(
        snapshot.data[index],
      ),
    );
  }

  Widget message(MessageModel message) {
    bool currentUser = message.user.id == controller.user.id;

    return Container(
      alignment: currentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: currentUser ? Theme.of(context).primaryColor : null,
        child: Container(
          width: MediaQuery.of(context).size.width * .75,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: currentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: !currentUser,
                  child: Text(
                    message.user.name,
                    style: TextStyle(
                      color: Colors.primaries[message.user.id],
                    ),
                  ),
                ),
                Text(message.text),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    formatDate(message.createdAt),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) => DateFormat.jm().format(
        date.toLocal(),
      );
}
