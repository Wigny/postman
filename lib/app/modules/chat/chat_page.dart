import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/modules/chat/chat_controller.dart';
import 'package:postman/app/modules/chat/chat_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({Key key, this.title = "Chat"}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = ChatModule.to.bloc<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: GestureDetector(
          onTap: () => {},
          child: Row(
            children: <Widget>[
              UserImageWidget(
                image: controller.chat.image,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(controller.chat.name),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Observer(
                builder: (BuildContext context) => ListView.builder(
                  itemCount: controller.messageList.length,
                  itemBuilder: (BuildContext context, int index) => _message(
                    controller.messageList[index],
                  ),
                ),
              ),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Observer(
                builder: (BuildContext context) => TextField(
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Digite uma mensagem",
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.attach_file,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    filled: true,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  autofocus: false,
                  textInputAction: TextInputAction.send,
                  controller: controller.input,
                  onSubmitted: (v) => controller.submitMessage(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: FloatingActionButton(
              child: Icon(Icons.send),
              elevation: 0,
              onPressed: controller.submitMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _message(MessageModel message) {
    bool itsMe = message.user.id == controller.user.id;

    var alignment = Alignment.centerLeft;
    var crossAxisAlignment = CrossAxisAlignment.start;

    if (itsMe) {
      alignment = Alignment.centerRight;
      crossAxisAlignment = CrossAxisAlignment.end;
    }

    return Container(
      alignment: alignment,
      child: Card(
        color: (itsMe) ? Theme.of(context).primaryColor : null,
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
                Text((message.content != null) ? message.content : ''),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    controller.formatDate(message.sendingAt),
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
}
