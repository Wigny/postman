// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_info_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatInfoController on _ChatInfoBase, Store {
  final _$userListAtom = Atom(name: '_ChatInfoBase.userList');

  @override
  ObservableList<UserModel> get userList {
    _$userListAtom.context.enforceReadPolicy(_$userListAtom);
    _$userListAtom.reportObserved();
    return super.userList;
  }

  @override
  set userList(ObservableList<UserModel> value) {
    _$userListAtom.context.conditionallyRunInAction(() {
      super.userList = value;
      _$userListAtom.reportChanged();
    }, _$userListAtom, name: '${_$userListAtom.name}_set');
  }
}
