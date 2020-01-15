import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/modules/chat/chat_controller.dart';
import 'package:postman/app/modules/chat/chat_module.dart';

void main() {
  initModule(ChatModule());

  ChatController chat;

  setUp(() {
    chat = ChatModule.to.get<ChatController>();
  });

  group('ChatController Test', () {
    test("First Test", () {
      expect(chat, isInstanceOf<ChatController>());
    });

    test("Set Value", () {
      expect(chat.value, equals(0));
      chat.increment();
      expect(chat.value, equals(1));
    });
  });
}
