import 'package:mobx/mobx.dart';
import 'package:postman/app/models/media_model.dart';
import 'package:postman/app/models/user_model.dart';

part 'sign_in_controller.g.dart';

class SignInController = _SignInBase with _$SignInController;

abstract class _SignInBase with Store {
  UserModel user;

  @observable
  String nickname = '';

  @action
  setNickname(String v) => nickname = v;

  @computed
  UserModel get getUser => (nickname == 'wigny')
      ? UserModel(
          id: 4,
          nickname: 'wigny',
          username: 'Wígny',
          image: MediaModel(
            url:
                "https://storagepostman.blob.core.windows.net/files/552ee9b3-d9b1-4fd6-b457-3c3f791669b6.jpeg",
            mimetype: "image/jpeg",
          ),
        )
      : user;

  bool get isValid => user != null || nickname.isNotEmpty;
}
