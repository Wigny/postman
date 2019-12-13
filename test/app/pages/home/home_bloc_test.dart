import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/pages/home/home_bloc.dart';
import 'package:postman/app/app_module.dart';

void main() {
  initModule(AppModule());
  HomeBloc bloc;

  setUp(() {
    bloc = AppModule.to.bloc<HomeBloc>();
  });

  group('HomeBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<HomeBloc>());
    });
  });
}
