// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fair_price_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FairPriceStore on _FairPriceStoreBase, Store {
  late final _$fairPricesFromListAtom =
      Atom(name: '_FairPriceStoreBase.fairPricesFromList', context: context);

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

  late final _$priceAtom =
      Atom(name: '_FairPriceStoreBase.price', context: context);

  @override
  double? get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(double? value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  late final _$fairPriceStatusAtom =
      Atom(name: '_FairPriceStoreBase.fairPriceStatus', context: context);

  @override
  AppState get fairPriceStatus {
    _$fairPriceStatusAtom.reportRead();
    return super.fairPriceStatus;
  }

  @override
  set fairPriceStatus(AppState value) {
    _$fairPriceStatusAtom.reportWrite(value, super.fairPriceStatus, () {
      super.fairPriceStatus = value;
    });
  }

  late final _$_FairPriceStoreBaseActionController =
      ActionController(name: '_FairPriceStoreBase', context: context);

  @override
  dynamic setPrice(double? value) {
    final _$actionInfo = _$_FairPriceStoreBaseActionController.startAction(
        name: '_FairPriceStoreBase.setPrice');
    try {
      return super.setPrice(value);
    } finally {
      _$_FairPriceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fairPricesFromList: ${fairPricesFromList},
price: ${price},
fairPriceStatus: ${fairPriceStatus}
    ''';
  }
}
