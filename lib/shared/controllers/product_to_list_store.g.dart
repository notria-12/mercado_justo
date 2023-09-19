// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_to_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductToListStore on _ProductToListStoreBase, Store {
  late final _$productIdAtom =
      Atom(name: '_ProductToListStoreBase.productId', context: context);

  @override
  int? get productId {
    _$productIdAtom.reportRead();
    return super.productId;
  }

  @override
  set productId(int? value) {
    _$productIdAtom.reportWrite(value, super.productId, () {
      super.productId = value;
    });
  }

  late final _$valueAtom =
      Atom(name: '_ProductToListStoreBase.value', context: context);

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$_ProductToListStoreBaseActionController =
      ActionController(name: '_ProductToListStoreBase', context: context);

  @override
  void increment() {
    final _$actionInfo = _$_ProductToListStoreBaseActionController.startAction(
        name: '_ProductToListStoreBase.increment');
    try {
      return super.increment();
    } finally {
      _$_ProductToListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$_ProductToListStoreBaseActionController.startAction(
        name: '_ProductToListStoreBase.decrement');
    try {
      return super.decrement();
    } finally {
      _$_ProductToListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productId: ${productId},
value: ${value}
    ''';
  }
}
