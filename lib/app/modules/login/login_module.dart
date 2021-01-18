import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/repositories/hive_repository.dart';

import 'login_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => LoginBloc(
            i.get<HasuraConnect>(),
            i.get<HiveRepository>(),
          ),
        )
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LoginPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
