import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/modules/sign_in/sign_in_page.dart';

main() {
  testWidgets('SignInPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SignInPage(title: 'SignIn')));
    final titleFinder = find.text('SignIn');
    expect(titleFinder, findsOneWidget);
  });
}
