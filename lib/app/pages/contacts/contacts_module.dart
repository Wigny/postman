import 'package:postman/app/app_module.dart';
import 'package:postman/app/pages/contacts/contacts_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/pages/contacts/contacts_page.dart';
import 'package:postman/app/repositories/hasura_repository.dart';

class ContactsModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => ContactsBloc(AppModule.to.get<HasuraRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ContactsPage();

  static Inject get to => Inject<ContactsModule>.of();
}
