import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/models/chat.model.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/hive_repository.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc extends Disposable {
  final UserModel user = UserModel(id: 1, name: "Wigny");
  final ChatModel chat;
  final HasuraConnect hasura;
  final HiveRepository hive;

  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Snapshot snapshot;
  BehaviorSubject<List<MessageModel>> messages = BehaviorSubject();

  ChatBloc(this.chat, this.hasura, this.hive) {
    getMessages();
  }

  getMessages() async {
    String subscription = """
      subscription Messages(\$chat_id: Int!) {
        messages(limit: 100, order_by: {id: desc}, where: {chat_id: {_eq: \$chat_id}}) {
          id
          text
          created_at
          user {
            id
            name
          },
          chat_id
        }
      }
    """;

    List<MessageModel> convert(json) => json != null
        ? json["data"]["messages"]
            .map<MessageModel>(
              (i) => MessageModel.fromMap(i),
            )
            .toList()
        : [];

    snapshot = await hasura.subscription(subscription, variables: {
      "chat_id": chat.id,
    });
    snapshot.map(convert).pipe(messages);
    messages.listen(scrollListView);

    snapshot.doOnCancel(messages.close);
  }

  void submit([String value]) {
    String mutation = """
      mutation InsertMessages(\$message: [messages_insert_input!]!)  {
        insert_messages(objects: \$message) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      'message': MessageModel(
        text: value ?? textController.text,
        user: user,
        chatId: chat.id,
      ).toMap()
    };

    hasura.mutation(mutation, variables: variables);
    textController.clear();
  }

  void scrollListView(_) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  void dispose() {
    snapshot?.close();
  }
}
