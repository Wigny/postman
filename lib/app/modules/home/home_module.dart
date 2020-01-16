import 'package:postman/app/app_module.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/modules/home/home_controller.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/modules/home/home_page.dart';
import 'package:postman/app/repositories/hasura_repository.dart';

class HomeModule extends ModuleWidget {
  final UserModel user;

  HomeModule(this.user);

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => HomeController(
            AppModule.to.get<HasuraRepository>(),
            user,
          ),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}