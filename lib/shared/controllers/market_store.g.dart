// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MarketStore on _MarketStoreBase, Store {
  late final _$marketsAtom =
      Atom(name: '_MarketStoreBase.markets', context: context);

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

  late final _$groupMarketsAtom =
      Atom(name: '_MarketStoreBase.groupMarkets', context: context);

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

  late final _$marketStatusAtom =
      Atom(name: '_MarketStoreBase.marketStatus', context: context);

  @override
  AppState get marketStatus {
    _$marketStatusAtom.reportRead();
    return super.marketStatus;
  }

  @override
  set marketStatus(AppState value) {
    _$marketStatusAtom.reportWrite(value, super.marketStatus, () {
      super.marketStatus = value;
    });
  }

  late final _$pageAtom = Atom(name: '_MarketStoreBase.page', context: context);

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

  late final _$filteredMarketsAtom =
      Atom(name: '_MarketStoreBase.filteredMarkets', context: context);

  @override
  List<Market> get filteredMarkets {
    _$filteredMarketsAtom.reportRead();
    return super.filteredMarkets;
  }

  @override
  set filteredMarkets(List<Market> value) {
    _$filteredMarketsAtom.reportWrite(value, super.filteredMarkets, () {
      super.filteredMarkets = value;
    });
  }

  late final _$_MarketStoreBaseActionController =
      ActionController(name: '_MarketStoreBase', context: context);

  @override
  dynamic setFilteredMarkets(List<Market> newMarkets) {
    final _$actionInfo = _$_MarketStoreBaseActionController.startAction(
        name: '_MarketStoreBase.setFilteredMarkets');
    try {
      return super.setFilteredMarkets(newMarkets);
    } finally {
      _$_MarketStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
markets: ${markets},
groupMarkets: ${groupMarkets},
marketStatus: ${marketStatus},
page: ${page},
filteredMarkets: ${filteredMarkets}
    ''';
  }
}
