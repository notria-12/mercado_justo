// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  late final _$phoneNumberAtom =
      Atom(name: '_LoginStoreBase.phoneNumber', context: context);

  @override
  String? get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String? value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$codeAtom = Atom(name: '_LoginStoreBase.code', context: context);

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$verificationIdAtom =
      Atom(name: '_LoginStoreBase.verificationId', context: context);

  @override
  String? get verificationId {
    _$verificationIdAtom.reportRead();
    return super.verificationId;
  }

  @override
  set verificationId(String? value) {
    _$verificationIdAtom.reportWrite(value, super.verificationId, () {
      super.verificationId = value;
    });
  }

  late final _$signupStateAtom =
      Atom(name: '_LoginStoreBase.signupState', context: context);

  @override
  AppState get signupState {
    _$signupStateAtom.reportRead();
    return super.signupState;
  }

  @override
  set signupState(AppState value) {
    _$signupStateAtom.reportWrite(value, super.signupState, () {
      super.signupState = value;
    });
  }

  late final _$loginStateAtom =
      Atom(name: '_LoginStoreBase.loginState', context: context);

  @override
  AppState get loginState {
    _$loginStateAtom.reportRead();
    return super.loginState;
  }

  @override
  set loginState(AppState value) {
    _$loginStateAtom.reportWrite(value, super.loginState, () {
      super.loginState = value;
    });
  }

  late final _$sendLoginCodeStateAtom =
      Atom(name: '_LoginStoreBase.sendLoginCodeState', context: context);

  @override
  AppState get sendLoginCodeState {
    _$sendLoginCodeStateAtom.reportRead();
    return super.sendLoginCodeState;
  }

  @override
  set sendLoginCodeState(AppState value) {
    _$sendLoginCodeStateAtom.reportWrite(value, super.sendLoginCodeState, () {
      super.sendLoginCodeState = value;
    });
  }

  @override
  String toString() {
    return '''
phoneNumber: ${phoneNumber},
code: ${code},
verificationId: ${verificationId},
signupState: ${signupState},
loginState: ${loginState},
sendLoginCodeState: ${sendLoginCodeState}
    ''';
  }
}
