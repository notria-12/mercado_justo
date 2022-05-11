// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListStore on _ListStoreBase, Store {
  final _$product_listAtom = Atom(name: '_ListStoreBase.product_list');

  @override
  List<ListModel> get product_list {
    _$product_listAtom.reportRead();
    return super.product_list;
  }

  @override
  set product_list(List<ListModel> value) {
    _$product_listAtom.reportWrite(value, super.product_list, () {
      super.product_list = value;
    });
  }

  final _$listStateAtom = Atom(name: '_ListStoreBase.listState');

  @override
  AppState get listState {
    _$listStateAtom.reportRead();
    return super.listState;
  }

  @override
  set listState(AppState value) {
    _$listStateAtom.reportWrite(value, super.listState, () {
      super.listState = value;
    });
  }

  @override
  String toString() {
    return '''
product_list: ${product_list},
listState: ${listState}
    ''';
  }
}
