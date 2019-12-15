import 'package:postman/app/app_module.dart';
import 'package:postman/app/pages/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/pages/login/login_page.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => LoginBloc(
            AppModule.to.get<HasuraRepository>(),
          ),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
