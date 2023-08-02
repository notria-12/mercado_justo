// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on _AuthControllerBase, Store {
  Computed<bool>? _$isUserAutenticatedComputed;

  @override
  bool get isUserAutenticated => (_$isUserAutenticatedComputed ??=
          Computed<bool>(() => super.isUserAutenticated,
              name: '_AuthControllerBase.isUserAutenticated'))
      .value;

  late final _$inviteIdAtom =
      Atom(name: '_AuthControllerBase.inviteId', context: context);

  @override
  String? get inviteId {
    _$inviteIdAtom.reportRead();
    return super.inviteId;
  }

  @override
  set inviteId(String? value) {
    _$inviteIdAtom.reportWrite(value, super.inviteId, () {
      super.inviteId = value;
    });
  }

  late final _$userAtom =
      Atom(name: '_AuthControllerBase.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_AuthControllerBase.state', context: context);

  @override
  AuthState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase', context: context);

  @override
  dynamic update(AuthState value) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.update');
    try {
      return super.update(value);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inviteId: ${inviteId},
user: ${user},
state: ${state},
isUserAutenticated: ${isUserAutenticated}
    ''';
  }
}
