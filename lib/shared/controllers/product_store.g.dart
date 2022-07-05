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

  final _$isSearchAtom = Atom(name: '_ProductStoreBase.isSearch');

  @override
  bool get isSearch {
    _$isSearchAtom.reportRead();
    return super.isSearch;
  }

  @override
  set isSearch(bool value) {
    _$isSearchAtom.reportWrite(value, super.isSearch, () {
      super.isSearch = value;
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

  final _$canLoadMoreAtom = Atom(name: '_ProductStoreBase.canLoadMore');

  @override
  bool get canLoadMore {
    _$canLoadMoreAtom.reportRead();
    return super.canLoadMore;
  }

  @override
  set canLoadMore(bool value) {
    _$canLoadMoreAtom.reportWrite(value, super.canLoadMore, () {
      super.canLoadMore = value;
    });
  }

  final _$onlyButtonLoadMoreAtom =
      Atom(name: '_ProductStoreBase.onlyButtonLoadMore');

  @override
  bool get onlyButtonLoadMore {
    _$onlyButtonLoadMoreAtom.reportRead();
    return super.onlyButtonLoadMore;
  }

  @override
  set onlyButtonLoadMore(bool value) {
    _$onlyButtonLoadMoreAtom.reportWrite(value, super.onlyButtonLoadMore, () {
      super.onlyButtonLoadMore = value;
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
isSearch: ${isSearch},
productState: ${productState},
canLoadMore: ${canLoadMore},
onlyButtonLoadMore: ${onlyButtonLoadMore},
page: ${page}
    ''';
  }
}
