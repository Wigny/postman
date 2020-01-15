// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatBase, Store {
  final _$messageListAtom = Atom(name: '_ChatBase.messageList');

  @override
  ObservableList<MessageModel> get messageList {
    _$messageListAtom.context.enforceReadPolicy(_$messageListAtom);
    _$messageListAtom.reportObserved();
    return super.messageList;
  }

  @override
  set messageList(ObservableList<MessageModel> value) {
    _$messageListAtom.context.conditionallyRunInAction(() {
      super.messageList = value;
      _$messageListAtom.reportChanged();
    }, _$messageListAtom, name: '${_$messageListAtom.name}_set');
  }

  final _$_ChatBaseActionController = ActionController(name: '_ChatBase');

  @override
  dynamic addMessage(MessageModel message) {
    final _$actionInfo = _$_ChatBaseActionController.startAction();
    try {
      return super.addMessage(message);
    } finally {
      _$_ChatBaseActionController.endAction(_$actionInfo);
    }
  }
}
