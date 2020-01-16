import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/modules/chat_info/chat_info_controller.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/modules/chat_info/chat_info_page.dart';

class ChatInfoModule extends ModuleWidget {
  final ChatModel chat;

  ChatInfoModule(this.chat);

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => ChatInfoController(
            chat,
          ),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ChatInfoPage();

  static Inject get to => Inject<ChatInfoModule>.of();
}
