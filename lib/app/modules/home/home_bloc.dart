import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/models/chat.model.dart';
import 'package:postman/app/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Disposable {
  final HasuraConnect hasura;
  final UserModel user;

  Snapshot snapshot;
  BehaviorSubject<List<ChatModel>> chats = BehaviorSubject();

  HomeBloc(this.user, this.hasura) {
    getChats();
  }

  getChats() async {
    String subscription = """
      subscription Chats {
        chats {
          id
          title
          description
          created_at
        }
      }
    """;

    List<ChatModel> convert(json) => json != null
        ? json["data"]["chats"]
            .map<ChatModel>(
              (i) => ChatModel.fromMap(i),
            )
            .toList()
        : [];

    snapshot = await hasura.subscription(subscription);
    snapshot.map(convert).pipe(chats);
  }

  @override
  void dispose() {
    snapshot?.close();
    chats?.close();
  }
}
