// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductStore on _ProductStoreBase, Store {
  final _$productsAtom = Atom(name: '_ProductStoreBase.products');

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

  final _$searchProductsResultAtom =
      Atom(name: '_ProductStoreBase.searchProductsResult');

  @override
  List<Product> get searchProductsResult {
    _$searchProductsResultAtom.reportRead();
    return super.searchProductsResult;
  }

  @override
  set searchProductsResult(List<Product> value) {
    _$searchProductsResultAtom.reportWrite(value, super.searchProductsResult,
        () {
      super.searchProductsResult = value;
    });
  }

  final _$searchProductsStateAtom =
      Atom(name: '_ProductStoreBase.searchProductsState');

  @override
  AppState get searchProductsState {
    _$searchProductsStateAtom.reportRead();
    return super.searchProductsState;
  }

  @override
  set searchProductsState(AppState value) {
    _$searchProductsStateAtom.reportWrite(value, super.searchProductsState, () {
      super.searchProductsState = value;
    });
  }

  final _$productStateAtom = Atom(name: '_ProductStoreBase.productState');

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

  final _$pageAtom = Atom(name: '_ProductStoreBase.page');

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

  @override
  String toString() {
    return '''
products: ${products},
searchProductsResult: ${searchProductsResult},
searchProductsState: ${searchProductsState},
productState: ${productState},
page: ${page}
    ''';
  }
}
