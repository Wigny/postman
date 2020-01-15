import 'package:mobx/mobx.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/models/media_model.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/hasura_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final HasuraRepository hasura;
  UserModel user;

  @observable
  ObservableList<ChatModel> chatList = [
    ChatModel(
      messages: [
        MessageModel(
          user: UserModel(username: 'Wígny'),
          content: 'Oi',
        ),
      ],
      name: 'batata',
    ),
  ].asObservable();

  _HomeBase(this.hasura) {
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
  }
}
