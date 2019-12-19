import 'package:flutter/material.dart';
import 'package:postman/app/pages/chat/chat_bloc.dart';
import 'package:postman/app/pages/chat/chat_module.dart';

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
            CircleAvatar(
              backgroundImage: NetworkImage(bloc.chat.image),
            ),
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
            child: Container(),
            // StreamBuilder(
            //   stream: null,
            //   builder: _builder,
            // ),
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

  // Widget _builder(
  //   BuildContext context,
  //   AsyncSnapshot snapshot,
  // ) {
  //   if (!snapshot.hasData || snapshot.data.isEmpty)
  //     return Center(
  //       child: const Text('Você não possui messagens'),
  //     );

  //   return ListView.builder(
  //     padding: EdgeInsets.all(8),
  //     itemCount: snapshot.data.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _message(
  //         snapshot.data[index],
  //       );
  //     },
  //   );
  // }

  // Widget _message(message) {
  //   var alignment = Alignment.centerLeft;
  //   var color = Colors.white;

  //   if (message.emissor == bloc.chat.id) {
  //     alignment = Alignment.centerRight;
  //     color = Color(0xffe5ffcc);
  //   }

  //   return Container(
  //     alignment: alignment,
  //     child: Card(
  //       color: color,
  //       child: Container(
  //         width: MediaQuery.of(context).size.width * .75,
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             message.content,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
