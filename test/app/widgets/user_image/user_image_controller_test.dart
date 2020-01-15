import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:postman/app/widgets/user_image/user_image_controller.dart';
import 'package:postman/app/app_module.dart';

void main() {
  initModule(AppModule());

  UserImageController userimage;

  setUp(() {
    userimage = AppModule.to.get<UserImageController>();
  });

  group('UserImageController Test', () {
    test("First Test", () {
      expect(userimage, isInstanceOf<UserImageController>());
    });

    test("Set Value", () {
      expect(userimage.value, equals(0));
      userimage.increment();
      expect(userimage.value, equals(1));
    });
  });
}
