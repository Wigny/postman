import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:postman/app/modules/home/home_module.dart';
import 'package:postman/app/modules/login/login_module.dart';
import 'package:postman/app/modules/sign_in/sign_in_controller.dart';
import 'package:postman/app/modules/sign_in/sign_in_module.dart';
import 'package:postman/app/widgets/user_image/user_image_widget.dart';

class SignInPage extends StatefulWidget {
  final String title;
  const SignInPage({Key key, this.title = "SignIn"}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final controller = SignInModule.to.getBloc<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (controller.user != null)
                  ? Observer(
                      builder: (BuildContext context) => Column(
                        children: <Widget>[
                          Container(
                            width: 120,
                            height: 120,
                            child: UserImageWidget(
                              image: (controller.user != null &&
                                      controller.user.image != null)
                                  ? controller.user.image
                                  : null,
                              icon: Icons.person,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(controller.user.username),
                          )
                        ],
                      ),
                    )
                  : Observer(
                      builder: (BuildContext context) => _input(
                        label: 'Nickname',
                        icon: Icons.lock_outline,
                        onChanged: controller.setNickname,
                      ),
                    ),
              Observer(
                builder: (BuildContext context) => _button(
                  label: 'Entrar',
                  onPressed: controller.isValid
                      ? () => _openPage(
                            HomeModule(
                              controller.getUser,
                            ),
                          )
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: FlatButton(
                  onPressed: () => _openPage(
                    LoginModule(),
                  ),
                  child: Text(
                    'Eu não tenho conta...',
                  ),
                ),
              ),
            ],
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
