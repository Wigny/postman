import 'package:mobx/mobx.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/models/media_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/hasura_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final HasuraRepository hasura;
  final UserModel user;

  static var chatTest = ChatModel(
    description: "Capivaras de todo o país",
    id: 1,
    name: "CapivaraBR",
    image: MediaModel(
      filename: "02d38218-9d97-40a4-82e7-b7bd75e40894.jpg",
      mimetype: "image/jpeg",
      url:
          "https://storagepostman.blob.core.windows.net/files/02d38218-9d97-40a4-82e7-b7bd75e40894.jpg",
    ),
    messages: [],
  );

  @observable
  ObservableList<ChatModel> chatList = <ChatModel>[chatTest].asObservable();

  _HomeBase(this.hasura, this.user);
}
