// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeAuthStore on _HomeAuthStoreBase, Store {
  final _$currentIndexAtom = Atom(name: '_HomeAuthStoreBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$_HomeAuthStoreBaseActionController =
      ActionController(name: '_HomeAuthStoreBase');

  @override
  void onTabTapped(int index) {
    final _$actionInfo = _$_HomeAuthStoreBaseActionController.startAction(
        name: '_HomeAuthStoreBase.onTabTapped');
    try {
      return super.onTabTapped(index);
    } finally {
      _$_HomeAuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex}
    ''';
  }
}
