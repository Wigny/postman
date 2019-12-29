import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/constants.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:rxdart/subjects.dart';

class ChatInfoBloc extends BlocBase {
  final ChatModel chat;
  final HasuraRepository _hasura;

  final _controller = BehaviorSubject<List<UserModel>>();
  Stream<List<UserModel>> get userListStream => _controller.stream;
  Sink<List<UserModel>> get userListEvent => _controller.sink;

  ChatInfoBloc(this.chat, this._hasura) {
    _hasura.query(
      GET_USERS_CHAT,
      variables: {
        'chat_id': chat.id,
      },
    ).then((data) {
      List<UserModel> _users = data['user_chats']
          .map<UserModel>(
            (i) => UserModel.fromJson(i['user']),
          )
          .toList();

      userListEvent.add(_users);
    }).catchError(print);
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }
}
