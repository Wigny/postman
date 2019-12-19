import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/constants.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:rxdart/rxdart.dart';

class ContactsBloc extends BlocBase {
  final HasuraRepository _hasura;

  final _controller = BehaviorSubject<List<UserModel>>();
  Stream<List<UserModel>> get userListFlux => _controller.stream;
  Sink<List<UserModel>> get userListEvent => _controller.sink;

  ContactsBloc(this._hasura) {
    _hasura.query(GET_USERS).then((data) {
      List<UserModel> _users = data['user']
          .map<UserModel>(
            (i) => UserModel.fromJson(i),
          )
          .toList();

      userListEvent.add(_users);
    }).catchError(
      (err) => print('ó o erro aqui, meu povo: $err'),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
