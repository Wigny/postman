// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInController on _SignInBase, Store {
  Computed<UserModel> _$getUserComputed;

  @override
  UserModel get getUser =>
      (_$getUserComputed ??= Computed<UserModel>(() => super.getUser)).value;

  final _$nicknameAtom = Atom(name: '_SignInBase.nickname');

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

  final _$_SignInBaseActionController = ActionController(name: '_SignInBase');

  @override
  dynamic setNickname(String v) {
    final _$actionInfo = _$_SignInBaseActionController.startAction();
    try {
      return super.setNickname(v);
    } finally {
      _$_SignInBaseActionController.endAction(_$actionInfo);
    }
  }
}
