// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InitialStore on InitialStoreBase, Store {
  late final _$productStateAtom =
      Atom(name: 'InitialStoreBase.productState', context: context);

  @override
  AppState get productState {
    _$productStateAtom.reportRead();
    return super.productState;
  }

  @override
  set productState(AppState value) {
    _$productStateAtom.reportWrite(value, super.productState, () {
      super.productState = value;
    });
  }

  late final _$marketStateAtom =
      Atom(name: 'InitialStoreBase.marketState', context: context);

  @override
  AppState get marketState {
    _$marketStateAtom.reportRead();
    return super.marketState;
  }

  @override
  set marketState(AppState value) {
    _$marketStateAtom.reportWrite(value, super.marketState, () {
      super.marketState = value;
    });
  }

  late final _$allPriceStatusAtom =
      Atom(name: 'InitialStoreBase.allPriceStatus', context: context);

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

  late final _$groupMarketsAtom =
      Atom(name: 'InitialStoreBase.groupMarkets', context: context);

  @override
  List<List<Market>> get groupMarkets {
    _$groupMarketsAtom.reportRead();
    return super.groupMarkets;
  }

  @override
  set groupMarkets(List<List<Market>> value) {
    _$groupMarketsAtom.reportWrite(value, super.groupMarkets, () {
      super.groupMarkets = value;
    });
  }

  late final _$pricesAtom =
      Atom(name: 'InitialStoreBase.prices', context: context);

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
productState: ${productState},
marketState: ${marketState},
allPriceStatus: ${allPriceStatus},
groupMarkets: ${groupMarkets},
prices: ${prices}
    ''';
  }
}
