import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:postman/app/models/chat_model.dart';

class ChatBloc extends BlocBase {
  final ChatModel chat;
  final HasuraRepository _hasura;

  ChatBloc(this.chat, this._hasura);

  @override
  void dispose() {
    super.dispose();
  }
}
