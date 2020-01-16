import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/modules/sign_in/sign_in_controller.dart';
import 'package:postman/app/modules/sign_in/sign_in_module.dart';

void main() {
  initModule(SignInModule());

  SignInController signin;

  setUp(() {
    signin = SignInModule.to.get<SignInController>();
  });

  group('SignInController Test', () {
    test("First Test", () {
      expect(signin, isInstanceOf<SignInController>());
    });

    test("Set Value", () {
      expect(signin.value, equals(0));
      signin.increment();
      expect(signin.value, equals(1));
    });
  });
}
