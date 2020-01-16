import 'package:mobx/mobx.dart';
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
      (nickname == 'wigny') ? 'O nickname já está em uso' : null;

  @computed
  bool get isValid =>
      username.isNotEmpty && nickname.isNotEmpty && validateNickname == null;

  @computed
  UserModel get getUser => UserModel(
        id: 999,
        nickname: nickname,
        username: username,
      );
}
