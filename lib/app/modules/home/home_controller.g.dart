// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  final _$chatListAtom = Atom(name: '_HomeBase.chatList');

  @override
  ObservableList<ChatModel> get chatList {
    _$chatListAtom.context.enforceReadPolicy(_$chatListAtom);
    _$chatListAtom.reportObserved();
    return super.chatList;
  }

  @override
  set chatList(ObservableList<ChatModel> value) {
    _$chatListAtom.context.conditionallyRunInAction(() {
      super.chatList = value;
      _$chatListAtom.reportChanged();
    }, _$chatListAtom, name: '${_$chatListAtom.name}_set');
  }
}
