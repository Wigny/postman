import 'package:postman/app/models/chat_model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/modules/chat/chat_controller.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/modules/chat/chat_page.dart';

class ChatModule extends ModuleWidget {
  final ChatModel chat;
  final UserModel user;

  ChatModule(this.chat, this.user);

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => ChatController(
            chat,
            user,
          ),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ChatPage();

  static Inject get to => Inject<ChatModule>.of();
}
