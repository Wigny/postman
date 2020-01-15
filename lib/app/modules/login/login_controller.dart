import 'package:mobx/mobx.dart';
import 'package:postman/app/models/media_model.dart';
import 'package:postman/app/models/user_model.dart';

part 'login_controller.g.dart';

class LoginController = _LoginBase with _$LoginController;

abstract class _LoginBase with Store {
  @observable
  String username = '';

  @observable
  String nickname = '';

  @action
  setUsername(String v) => username = v;

  @action
  setNickname(String v) => nickname = v;

  String get validateNickname =>
      (nickname == 'w') ? 'O nickname já está em uso' : null;

  @computed
  bool get isValid =>
      username.isNotEmpty && nickname.isNotEmpty && validateNickname == null;

  UserModel get getUser => UserModel(
        id: 4,
        nickname: nickname,
        username: username,
        image: MediaModel(
          url:
              "https://storagepostman.blob.core.windows.net/files/552ee9b3-d9b1-4fd6-b457-3c3f791669b6.jpeg",
          mimetype: "image/jpeg",
        ),
      );
}
