import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:postman/app/modules/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Criar usuário",
              ),
              onSubmitted: controller.createUser,
            ),
            Expanded(
              child: StreamBuilder<List<UserModel>>(
                stream: controller.users,
                builder: builder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget builder(
    BuildContext context,
    AsyncSnapshot snapshot,
  ) {
    if (!snapshot.hasData)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (snapshot.data.isEmpty)
      return Chip(
        label: Text('Não há messagens'),
      );

    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) => user(
        snapshot.data[index],
      ),
    );
  }

  Widget user(UserModel user) {
    return ListTile(
      title: Text(user.name),
      leading: Icon(Icons.people),
      onTap: () => controller.selectUser(user),
    );
  }
}
