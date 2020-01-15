import 'package:mobx/mobx.dart';
import 'package:postman/app/models/user_model.dart';

part 'contacts_controller.g.dart';

class ContactsController = _ContactsBase with _$ContactsController;

abstract class _ContactsBase with Store {
  @observable
  ObservableList<UserModel> userList = <UserModel>[].asObservable();
}
