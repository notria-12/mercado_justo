// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

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

  final _$product_listAtom = Atom(name: '_ListStoreBase.product_list');

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

  final _$productsAtom = Atom(name: '_ListStoreBase.products');

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

  final _$pricesAtom = Atom(name: '_ListStoreBase.prices');

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

  final _$quantitiesAtom = Atom(name: '_ListStoreBase.quantities');

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

  final _$marketSelectedAtom = Atom(name: '_ListStoreBase.marketSelected');

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

  final _$listStateAtom = Atom(name: '_ListStoreBase.listState');

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

  final _$productStateAtom = Atom(name: '_ListStoreBase.productState');

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

  final _$priceStateAtom = Atom(name: '_ListStoreBase.priceState');

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

  final _$updateQuantityStatusAtom =
      Atom(name: '_ListStoreBase.updateQuantityStatus');

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

  final _$_ListStoreBaseActionController =
      ActionController(name: '_ListStoreBase');

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
products: ${products},
prices: ${prices},
quantities: ${quantities},
marketSelected: ${marketSelected},
listState: ${listState},
productState: ${productState},
priceState: ${priceState},
updateQuantityStatus: ${updateQuantityStatus},
totalPrice: ${totalPrice},
missingProducts: ${missingProducts}
    ''';
  }
}
