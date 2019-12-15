import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/models/user_model.dart';

class HasuraRepository extends Disposable {
  final HasuraConnect connection;

  HasuraRepository(this.connection);

  Future<UserModel> getUser(String nickname) async {
    String query = '''
      getUser(\$nickname:String!){
        user(where: {nickname: {_eq: \$nickname}}) {
          id
          nickname
          username
          image
        }
      }
    ''';

    try {
      var data = await connection.query(
        query,
        variables: {'nickname': nickname},
      );

      return UserModel.fromJson(data['data']['user'][0]);
    } on HasuraError catch (e) {
      print(e);
      return null;
    }
  }

  Stream<List<MessageModel>> getLastMessage() {
    String query = '''
      subscription getLastMessage {
        message(order_by: {createdAt: desc}) {
            id
            content
            receptor
            user {
              id
              image
              nickname
              username
            }
            createdAt
          }
        }
    ''';

    try {
      Snapshot snapshot = connection.subscription(query);
      return snapshot.map(
        (data) => MessageModel.fromJsonList(data['data']['message']),
      );
    } on HasuraError catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void dispose() {}
}
