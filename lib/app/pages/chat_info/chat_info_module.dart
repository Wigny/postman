import 'package:postman/app/app_module.dart';
import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/pages/chat_info/chat_info_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/pages/chat_info/chat_info_page.dart';
import 'package:postman/app/repositories/hasura_repository.dart';

class ChatInfoModule extends ModuleWidget {
  final ChatModel chat;

  ChatInfoModule(this.chat);

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => ChatInfoBloc(
            chat,
            AppModule.to.get<HasuraRepository>(),
          ),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ChatInfoPage();

  static Inject get to => Inject<ChatInfoModule>.of();
}
