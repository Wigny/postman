import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:postman/app/models/message_model.dart';
import 'package:postman/app/repositories/hasura_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final HasuraRepository _hasura;

  final _controller = BehaviorSubject<List<MessageModel>>();
  Observable<List<MessageModel>> get messageListFlux => _controller.stream;
  Sink<List<MessageModel>> get messageListEvent => _controller.sink;

  HomeBloc(this._hasura) {
    _hasura
        .getLastMessage()
        .listen(
          (List<MessageModel> data) => messageListEvent.add(data),
        )
        .onError(
          (err) => print('error $err'),
        );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
