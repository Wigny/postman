import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/modules/contacts/contacts_page.dart';

main() {
  testWidgets('ContactsPage has title', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(ContactsPage(title: 'Contacts')));
    final titleFinder = find.text('Contacts');
    expect(titleFinder, findsOneWidget);
  });
}
