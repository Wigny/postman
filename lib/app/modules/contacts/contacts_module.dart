import 'package:postman/app/modules/contacts/contacts_controller.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/modules/contacts/contacts_page.dart';

class ContactsModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ContactsController()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ContactsPage();

  static Inject get to => Inject<ContactsModule>.of();
}
