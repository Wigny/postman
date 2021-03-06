import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/modules/chat/chat_module.dart';
import 'package:postman/app/modules/login/login_module.dart';
import 'package:postman/app/repositories/hive_repository.dart';
import 'package:postman/app/app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/app_widget.dart';
import 'package:postman/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => AppBloc(),
        ),
        Bind(
          (i) => HasuraConnect(
            'https://androidtv-chat.hasura.app/v1/graphql',
          ),
        ),
        Bind(
          (i) => HiveRepository(),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: LoginModule()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/chats', module: ChatModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
