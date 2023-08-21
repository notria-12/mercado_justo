// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterStore on _FilterStoreBase, Store {
  Computed<List<Market>>? _$filteredMarketsComputed;

  @override
  List<Market> get filteredMarkets => (_$filteredMarketsComputed ??=
          Computed<List<Market>>(() => super.filteredMarkets,
              name: '_FilterStoreBase.filteredMarkets'))
      .value;

  late final _$ratingAtom =
      Atom(name: '_FilterStoreBase.rating', context: context);

  @override
  double get rating {
    _$ratingAtom.reportRead();
    return super.rating;
  }

  @override
  set rating(double value) {
    _$ratingAtom.reportWrite(value, super.rating, () {
      super.rating = value;
    });
  }

  late final _$marketIdAtom =
      Atom(name: '_FilterStoreBase.marketId', context: context);

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

  late final _$marketsAtom =
      Atom(name: '_FilterStoreBase.markets', context: context);

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

  late final _$_FilterStoreBaseActionController =
      ActionController(name: '_FilterStoreBase', context: context);

  @override
  dynamic setMarkets(List<Market> newMarkets) {
    final _$actionInfo = _$_FilterStoreBaseActionController.startAction(
        name: '_FilterStoreBase.setMarkets');
    try {
      return super.setMarkets(newMarkets);
    } finally {
      _$_FilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
rating: ${rating},
marketId: ${marketId},
markets: ${markets},
filteredMarkets: ${filteredMarkets}
    ''';
  }
}
