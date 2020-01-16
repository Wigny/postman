import 'package:postman/app/modules/sign_in/sign_in_controller.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/modules/sign_in/sign_in_page.dart';

class SignInModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SignInController()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => SignInPage();

  static Inject get to => Inject<SignInModule>.of();
}
