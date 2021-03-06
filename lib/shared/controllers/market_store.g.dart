// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MarketStore on _MarketStoreBase, Store {
  Computed<List<Market>>? _$filteredMarketsComputed;

  @override
  List<Market> get filteredMarkets => (_$filteredMarketsComputed ??=
          Computed<List<Market>>(() => super.filteredMarkets,
              name: '_MarketStoreBase.filteredMarkets'))
      .value;

  final _$marketsAtom = Atom(name: '_MarketStoreBase.markets');

  @override
  List<Market> get markets {
    _$marketsAtom.reportRead();
    return super.markets;
  }

  @override
  set markets(List<Market> value) {
    _$marketsAtom.reportWrite(value, super.markets, () {
      super.markets = value;
    });
  }

  final _$groupMarketsAtom = Atom(name: '_MarketStoreBase.groupMarkets');

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

  final _$pageAtom = Atom(name: '_MarketStoreBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$marketIdAtom = Atom(name: '_MarketStoreBase.marketId');

  @override
  String? get marketId {
    _$marketIdAtom.reportRead();
    return super.marketId;
  }

  @override
  set marketId(String? value) {
    _$marketIdAtom.reportWrite(value, super.marketId, () {
      super.marketId = value;
    });
  }

  @override
  String toString() {
    return '''
markets: ${markets},
groupMarkets: ${groupMarkets},
page: ${page},
marketId: ${marketId},
filteredMarkets: ${filteredMarkets}
    ''';
  }
}
