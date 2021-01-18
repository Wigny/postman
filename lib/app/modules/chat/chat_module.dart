import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/repositories/hive_repository.dart';

import 'chat_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chat_page.dart';

class ChatModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => ChatBloc(
            i.args.data,
            i.get<HasuraConnect>(),
            i.get<HiveRepository>(),
          ),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/:id',
          child: (_, args) => ChatPage(chat: args.data),
        ),
      ];

  static Inject get to => Inject<ChatModule>.of();
}
