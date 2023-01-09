// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PriceStore on _PriceStoreBase, Store {
  final _$priceStatusAtom = Atom(name: '_PriceStoreBase.priceStatus');

  @override
  AppState get priceStatus {
    _$priceStatusAtom.reportRead();
    return super.priceStatus;
  }

  @override
  set priceStatus(AppState value) {
    _$priceStatusAtom.reportWrite(value, super.priceStatus, () {
      super.priceStatus = value;
    });
  }

  final _$allPriceStatusAtom = Atom(name: '_PriceStoreBase.allPriceStatus');

  @override
  AppState get allPriceStatus {
    _$allPriceStatusAtom.reportRead();
    return super.allPriceStatus;
  }

  @override
  set allPriceStatus(AppState value) {
    _$allPriceStatusAtom.reportWrite(value, super.allPriceStatus, () {
      super.allPriceStatus = value;
    });
  }

  final _$pricesAtom = Atom(name: '_PriceStoreBase.prices');

  @override
  List<List<String>> get prices {
    _$pricesAtom.reportRead();
    return super.prices;
  }

  @override
  set prices(List<List<String>> value) {
    _$pricesAtom.reportWrite(value, super.prices, () {
      super.prices = value;
    });
  }

  @override
  String toString() {
    return '''
priceStatus: ${priceStatus},
allPriceStatus: ${allPriceStatus},
prices: ${prices}
    ''';
  }
}
