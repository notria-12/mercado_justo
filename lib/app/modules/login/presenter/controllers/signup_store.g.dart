// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupStore on _SignupStoreBase, Store {
  late final _$sigupStateAtom =
      Atom(name: '_SignupStoreBase.sigupState', context: context);

  @override
  AppState get sigupState {
    _$sigupStateAtom.reportRead();
    return super.sigupState;
  }

  @override
  set sigupState(AppState value) {
    _$sigupStateAtom.reportWrite(value, super.sigupState, () {
      super.sigupState = value;
    });
  }

  @override
  String toString() {
    return '''
sigupState: ${sigupState}
    ''';
  }
}
