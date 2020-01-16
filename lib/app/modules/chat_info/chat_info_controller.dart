import 'package:mobx/mobx.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/models/user_model.dart';

part 'chat_info_controller.g.dart';

class ChatInfoController = _ChatInfoBase with _$ChatInfoController;

abstract class _ChatInfoBase with Store {
  final ChatModel chat;

  _ChatInfoBase(this.chat);

  @observable
  ObservableList<UserModel> userList = <UserModel>[].asObservable();
}
