import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/widgets/user_image/user_image_widget.dart';

main() {
  testWidgets('UserImageWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(UserImageWidget()));
    final textFinder = find.text('UserImage');
    expect(textFinder, findsOneWidget);
  });
}
