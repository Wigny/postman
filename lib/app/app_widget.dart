import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Postman',
      theme: ThemeData(
        primarySwatch: color,
        brightness: Brightness.dark,
        accentColor: Color(0xff075E53),
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }

  final MaterialColor color = MaterialColor(0xff075E53, {
    50: Color(0xffE1ECEA),
    100: Color(0xffB5CFCB),
    200: Color(0xff83AFA9),
    300: Color(0xff518E87),
    400: Color(0xff2C766D),
    500: Color(0xff075E53),
    600: Color(0xff06564C),
    700: Color(0xff054C42),
    800: Color(0xff044239),
    900: Color(0xff023129),
  });
}
