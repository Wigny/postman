import 'package:postman/app/app_module.dart';
import 'package:postman/app/pages/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/pages/home/home_page.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => HomeBloc(
            AppModule.to.get<HasuraRepository>(),
          ),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
