// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_by_email_code_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginByEmailCodeStore on _LoginByEmailCodeStoreBase, Store {
  final _$sendLoginCodeStateAtom =
      Atom(name: '_LoginByEmailCodeStoreBase.sendLoginCodeState');

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
sendLoginCodeState: ${sendLoginCodeState}
    ''';
  }
}
