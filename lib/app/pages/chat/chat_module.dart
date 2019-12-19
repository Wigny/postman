import 'package:postman/app/app_module.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/pages/chat/chat_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/pages/chat/chat_page.dart';
import 'package:postman/app/repositories/hasura_repository.dart';

class ChatModule extends ModuleWidget {
  final ChatModel chat;

  ChatModule(this.chat);

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => ChatBloc(
            chat,
            AppModule.to.get<HasuraRepository>(),
          ),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ChatPage();

  static Inject get to => Inject<ChatModule>.of();
}
