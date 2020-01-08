import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/models/media_model.dart';
import 'package:postman/app/models/user_chats_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/constants.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final HasuraRepository _hasura;
  UserModel user;

  Snapshot _getChatSubscription;
  final _controller = BehaviorSubject<List<UserChatsModel>>();
  Stream<List<UserChatsModel>> get chatListStream => _controller.stream;
  Sink<List<UserChatsModel>> get chatListEvent => _controller.sink;

  HomeBloc(this._hasura) {
    user = UserModel(
      id: 4,
      nickname: "wigny",
      username: "Wígny",
      image: MediaModel(
        url:
            "https://storagepostman.blob.core.windows.net/files/552ee9b3-d9b1-4fd6-b457-3c3f791669b6.jpeg",
        mimetype: "image/jpeg",
      ),
    );

    _getChat(user.id);
  }

  _getChat(int userId) {
    _getChatSubscription = _hasura.subscription(
      GET_CHAT,
      variables: {
        'user_id': userId,
      },
    );

    _getChatSubscription
        .map(
          (res) => res['data']['user_chats']
              .map<UserChatsModel>(
                (i) => UserChatsModel.fromJson(i),
              )
              .toList(),
        )
        .listen(chatListEvent.add);
  }

  @override
  void dispose() {
    _controller?.close();
    _getChatSubscription?.close();
    super.dispose();
  }
}
