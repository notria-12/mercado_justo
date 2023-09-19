// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListStore on _ListStoreBase, Store {
  Computed<double>? _$totalPriceComputed;

  @override
  double get totalPrice =>
      (_$totalPriceComputed ??= Computed<double>(() => super.totalPrice,
              name: '_ListStoreBase.totalPrice'))
          .value;
  Computed<Map<String, dynamic>>? _$missingProductsComputed;

  @override
  Map<String, dynamic> get missingProducts => (_$missingProductsComputed ??=
          Computed<Map<String, dynamic>>(() => super.missingProducts,
              name: '_ListStoreBase.missingProducts'))
      .value;
  Computed<List<List<Product>>>? _$groupProductsComputed;

  @override
  List<List<Product>> get groupProducts => (_$groupProductsComputed ??=
          Computed<List<List<Product>>>(() => super.groupProducts,
              name: '_ListStoreBase.groupProducts'))
      .value;

  late final _$product_listAtom =
      Atom(name: '_ListStoreBase.product_list', context: context);

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

  late final _$isFairPriceAtom =
      Atom(name: '_ListStoreBase.isFairPrice', context: context);

  @override
  bool get isFairPrice {
    _$isFairPriceAtom.reportRead();
    return super.isFairPrice;
  }

  @override
  set isFairPrice(bool value) {
    _$isFairPriceAtom.reportWrite(value, super.isFairPrice, () {
      super.isFairPrice = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_ListStoreBase.products', context: context);

  @override
  List<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$pricesAtom =
      Atom(name: '_ListStoreBase.prices', context: context);

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

  late final _$quantitiesAtom =
      Atom(name: '_ListStoreBase.quantities', context: context);

  @override
  List<int> get quantities {
    _$quantitiesAtom.reportRead();
    return super.quantities;
  }

  @override
  set quantities(List<int> value) {
    _$quantitiesAtom.reportWrite(value, super.quantities, () {
      super.quantities = value;
    });
  }

  late final _$marketSelectedAtom =
      Atom(name: '_ListStoreBase.marketSelected', context: context);

  @override
  int get marketSelected {
    _$marketSelectedAtom.reportRead();
    return super.marketSelected;
  }

  @override
  set marketSelected(int value) {
    _$marketSelectedAtom.reportWrite(value, super.marketSelected, () {
      super.marketSelected = value;
    });
  }

  late final _$listStateAtom =
      Atom(name: '_ListStoreBase.listState', context: context);

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

  late final _$productStateAtom =
      Atom(name: '_ListStoreBase.productState', context: context);

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

  late final _$priceStateAtom =
      Atom(name: '_ListStoreBase.priceState', context: context);

  @override
  AppState get priceState {
    _$priceStateAtom.reportRead();
    return super.priceState;
  }

  @override
  set priceState(AppState value) {
    _$priceStateAtom.reportWrite(value, super.priceState, () {
      super.priceState = value;
    });
  }

  late final _$updateQuantityStatusAtom =
      Atom(name: '_ListStoreBase.updateQuantityStatus', context: context);

  @override
  AppState get updateQuantityStatus {
    _$updateQuantityStatusAtom.reportRead();
    return super.updateQuantityStatus;
  }

  @override
  set updateQuantityStatus(AppState value) {
    _$updateQuantityStatusAtom.reportWrite(value, super.updateQuantityStatus,
        () {
      super.updateQuantityStatus = value;
    });
  }

  late final _$_ListStoreBaseActionController =
      ActionController(name: '_ListStoreBase', context: context);

  @override
  void setMarketSelected(int value) {
    final _$actionInfo = _$_ListStoreBaseActionController.startAction(
        name: '_ListStoreBase.setMarketSelected');
    try {
      return super.setMarketSelected(value);
    } finally {
      _$_ListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
product_list: ${product_list},
isFairPrice: ${isFairPrice},
products: ${products},
prices: ${prices},
quantities: ${quantities},
marketSelected: ${marketSelected},
listState: ${listState},
productState: ${productState},
priceState: ${priceState},
updateQuantityStatus: ${updateQuantityStatus},
totalPrice: ${totalPrice},
missingProducts: ${missingProducts},
groupProducts: ${groupProducts}
    ''';
  }
}
