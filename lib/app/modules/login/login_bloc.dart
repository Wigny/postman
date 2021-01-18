import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/repositories/hive_repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Disposable {
  final HasuraConnect hasura;
  final HiveRepository hive;

  TextEditingController textController = TextEditingController();
  BehaviorSubject<List<UserModel>> users = BehaviorSubject();

  LoginBloc(this.hasura, this.hive) {
    currentUser();
  }

  void currentUser() {
    hive.get('current_user').then((u) {
      if (u != null) {
        var map = Map<String, dynamic>.from(u);
        var user = UserModel.fromMap(map);

        openHome(user);
      } else {
        getUsers();
      }
    });
  }

  void getUsers() async {
    String query = """
      query Users {
        users {
          id
          name
        }
      }
    """;

    List<UserModel> convert(json) => json["data"]["users"]
        .map<UserModel>(
          (i) => UserModel.fromMap(i),
        )
        .toList();

    hasura.query(query).then(convert).then(users.sink.add);
  }

  void selectUser(UserModel user) async {
    await hive.put(
      'current_user',
      user.toMap(),
    );

    openHome(user);
  }

  void createUser(String value) async {
    String mutation = """
      mutation InsertUser(\$name: String!) {
        insert_users(objects: {name: \$name}) {
          returning {
            id
            name
          }
        }
      }
    """;

    final user = (json) => UserModel.fromMap(
          json["data"]["insert_users"]["returning"][0],
        );

    final add = (UserModel user) => users.add(
          users.value..add(user),
        );

    await hasura
        .mutation(mutation, variables: {
          'name': value,
        })
        .then(user)
        .then(add);

    textController.text = '';
  }

  void openHome(UserModel user) {
    Modular.navigator.popAndPushNamed(
      '/home',
      arguments: user,
    );
  }

  @override
  void dispose() {
    users?.close();
  }
}
