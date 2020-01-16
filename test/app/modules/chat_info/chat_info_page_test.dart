import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/modules/chat_info/chat_info_page.dart';

main() {
  testWidgets('ChatInfoPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(ChatInfoPage(title: 'ChatInfo')));
    final titleFinder = find.text('ChatInfo');
    expect(titleFinder, findsOneWidget);
  });
}
