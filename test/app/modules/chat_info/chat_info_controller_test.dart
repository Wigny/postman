import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/modules/chat_info/chat_info_controller.dart';
import 'package:postman/app/modules/chat_info/chat_info_module.dart';

void main() {
  initModule(ChatInfoModule());

  ChatInfoController chatinfo;

  setUp(() {
    chatinfo = ChatInfoModule.to.get<ChatInfoController>();
  });

  group('ChatInfoController Test', () {
    test("First Test", () {
      expect(chatinfo, isInstanceOf<ChatInfoController>());
    });

    test("Set Value", () {
      expect(chatinfo.value, equals(0));
      chatinfo.increment();
      expect(chatinfo.value, equals(1));
    });
  });
}
