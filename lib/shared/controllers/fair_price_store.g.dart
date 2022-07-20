// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fair_price_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FairPriceStore on _FairPriceStoreBase, Store {
  final _$fairPricesFromListAtom =
      Atom(name: '_FairPriceStoreBase.fairPricesFromList');

  @override
  List<Map<dynamic, dynamic>> get fairPricesFromList {
    _$fairPricesFromListAtom.reportRead();
    return super.fairPricesFromList;
  }

  @override
  set fairPricesFromList(List<Map<dynamic, dynamic>> value) {
    _$fairPricesFromListAtom.reportWrite(value, super.fairPricesFromList, () {
      super.fairPricesFromList = value;
    });
  }

  @override
  String toString() {
    return '''
fairPricesFromList: ${fairPricesFromList}
    ''';
  }
}
