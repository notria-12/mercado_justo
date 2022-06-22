// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CompareStore on _CompareStoreBase, Store {
  Computed<List<List<Map<String, dynamic>>>>? _$getFairPriceComputed;

  @override
  List<List<Map<String, dynamic>>> get getFairPrice =>
      (_$getFairPriceComputed ??= Computed<List<List<Map<String, dynamic>>>>(
              () => super.getFairPrice,
              name: '_CompareStoreBase.getFairPrice'))
          .value;

  final _$pricesAtom = Atom(name: '_CompareStoreBase.prices');

  @override
  List<List<Map<String, dynamic>>> get prices {
    _$pricesAtom.reportRead();
    return super.prices;
  }

  @override
  set prices(List<List<Map<String, dynamic>>> value) {
    _$pricesAtom.reportWrite(value, super.prices, () {
      super.prices = value;
    });
  }

  @override
  String toString() {
    return '''
prices: ${prices},
getFairPrice: ${getFairPrice}
    ''';
  }
}
