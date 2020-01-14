import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:postman/app/repositories/constants.dart';
import 'package:postman/app/repositories/hasura_repository.dart';

class LoginBloc extends BlocBase {
  final HasuraRepository _hasura;

  LoginBloc(this._hasura);

  onLogin() {
    _hasura.query(GET_USERS, variables: {'nickname': 'wigny'}).then((data) {
      // UserModel user = data;
      print(data);
    });
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
