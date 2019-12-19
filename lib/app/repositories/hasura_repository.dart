import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HasuraRepository extends Disposable {
  final HasuraConnect connection;

  HasuraRepository(this.connection);

  Future<Map<String, dynamic>> query(String query,
      {Map<String, dynamic> variables}) async {
    try {
      var data = await connection.query(
        query,
        variables: variables,
      );

      return data['data'];
    } on HasuraError catch (e) {
      print(e);
      return null;
    }
  }

  Stream subscription(
    String query, {
    Map<String, dynamic> variables,
  }) {
    return connection.subscription(query, variables: variables);
  }

  @override
  void dispose() {}
}
