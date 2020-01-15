import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:postman/app/modules/home/home_module.dart';
import 'package:postman/app/modules/login/login_controller.dart';
import 'package:postman/app/modules/login/login_module.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginModule.to.getBloc<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Observer(
                  builder: (BuildContext context) => _input(
                    label: 'Nome',
                    helper:
                        'Esse é seu nome de usuário, ele será visível para todos.',
                    icon: Icons.person,
                    onChanged: controller.setUsername,
                  ),
                ),
                Observer(
                  builder: (BuildContext context) => _input(
                    label: 'Nickname',
                    error: controller.validateNickname,
                    helper:
                        'Esse é seu nickname, ele não é público e será utilizado como seu método de login.',
                    icon: Icons.lock_outline,
                    onChanged: controller.setNickname,
                  ),
                ),
                Observer(
                  builder: (BuildContext context) => _button(
                    label: 'Login',
                    onPressed: controller.isValid
                        ? () => _openPage(
                              HomeModule(controller.getUser),
                            )
                        : null,
                  ),
                ),
                Text(
                  'Já tenho uma conta...',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _button({String label, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        child: RaisedButton(
          child: Text(label),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
        ),
      ),
    );
  }

  Widget _input({
    String label,
    String helper,
    String error,
    IconData icon,
    Function onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          helperText: helper,
          errorText: error,
          icon: Icon(icon),
          helperMaxLines: 5,
        ),
        onChanged: onChanged,
      ),
    );
  }

  _openPage(pageModule) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => pageModule,
      ),
    );
  }
}
