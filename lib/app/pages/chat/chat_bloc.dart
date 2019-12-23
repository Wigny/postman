import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/constants.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc extends BlocBase {
  final ChatModel chat;
  final UserModel user;
  final HasuraRepository _hasura;

  TextEditingController textController = TextEditingController();

  Snapshot _getMessagesSubscription;

  final _controller = BehaviorSubject<List<MessageModel>>();
  Stream<List<MessageModel>> get messageListStream => _controller.stream;
  Sink<List<MessageModel>> get messageListEvent => _controller.sink;

  ChatBloc(this.chat, this.user, this._hasura) {
    _getMessages();
  }

  _getMessages() {
    _getMessagesSubscription = _hasura.subscription(
      GET_MESSAGES,
      variables: {'chat_id': chat.id},
    );

    _getMessagesSubscription
        .map(
          (res) => res['data']['chat'][0]['messages']
              .map<MessageModel>(
                (i) => MessageModel.fromJson(i),
              )
              .toList(),
        )
        .listen(messageListEvent.add)
        .onError(print);
  }

  submitMessage() {
    var message = MessageModel(
      content: textController.text,
      userId: user.id,
      chatId: chat.id,
    );

    _hasura.mutation(
      SEND_MESSAGE,
      variables: {'message': message.toJson()},
    ).catchError(print);

    textController.text = '';
  }

  @override
  void dispose() {
    _controller?.close();
    _getMessagesSubscription?.close();
    super.dispose();
  }
}
