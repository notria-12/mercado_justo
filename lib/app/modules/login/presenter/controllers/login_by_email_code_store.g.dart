// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_by_email_code_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginByEmailCodeStore on _LoginByEmailCodeStoreBase, Store {
  late final _$sendLoginCodeStateAtom = Atom(
      name: '_LoginByEmailCodeStoreBase.sendLoginCodeState', context: context);

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

  late final _$loginStateAtom =
      Atom(name: '_LoginByEmailCodeStoreBase.loginState', context: context);

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

  late final _$emailAtom =
      Atom(name: '_LoginByEmailCodeStoreBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$codeAtom =
      Atom(name: '_LoginByEmailCodeStoreBase.code', context: context);

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

  @override
  String toString() {
    return '''
sendLoginCodeState: ${sendLoginCodeState},
loginState: ${loginState},
email: ${email},
code: ${code}
    ''';
  }
}
