// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginBase, Store {
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid =>
      (_$isValidComputed ??= Computed<bool>(() => super.isValid)).value;

  final _$usernameAtom = Atom(name: '_LoginBase.username');

  @override
  String get username {
    _$usernameAtom.context.enforceReadPolicy(_$usernameAtom);
    _$usernameAtom.reportObserved();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.context.conditionallyRunInAction(() {
      super.username = value;
      _$usernameAtom.reportChanged();
    }, _$usernameAtom, name: '${_$usernameAtom.name}_set');
  }

  final _$nicknameAtom = Atom(name: '_LoginBase.nickname');

  @override
  String get nickname {
    _$nicknameAtom.context.enforceReadPolicy(_$nicknameAtom);
    _$nicknameAtom.reportObserved();
    return super.nickname;
  }

  @override
  set nickname(String value) {
    _$nicknameAtom.context.conditionallyRunInAction(() {
      super.nickname = value;
      _$nicknameAtom.reportChanged();
    }, _$nicknameAtom, name: '${_$nicknameAtom.name}_set');
  }

  final _$_LoginBaseActionController = ActionController(name: '_LoginBase');

  @override
  dynamic setUsername(String v) {
    final _$actionInfo = _$_LoginBaseActionController.startAction();
    try {
      return super.setUsername(v);
    } finally {
      _$_LoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNickname(String v) {
    final _$actionInfo = _$_LoginBaseActionController.startAction();
    try {
      return super.setNickname(v);
    } finally {
      _$_LoginBaseActionController.endAction(_$actionInfo);
    }
  }
}
