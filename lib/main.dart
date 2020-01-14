import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postman/app/app_module.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(new AppModule());
}
