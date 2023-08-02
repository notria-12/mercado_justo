// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on _ProductStoreBase, Store {
  late final _$productsAtom =
      Atom(name: '_ProductStoreBase.products', context: context);

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

  late final _$isSearchAtom =
      Atom(name: '_ProductStoreBase.isSearch', context: context);

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

  late final _$isCategorySearchAtom =
      Atom(name: '_ProductStoreBase.isCategorySearch', context: context);

  @override
  bool get isCategorySearch {
    _$isCategorySearchAtom.reportRead();
    return super.isCategorySearch;
  }

  @override
  set isCategorySearch(bool value) {
    _$isCategorySearchAtom.reportWrite(value, super.isCategorySearch, () {
      super.isCategorySearch = value;
    });
  }

  late final _$productStateAtom =
      Atom(name: '_ProductStoreBase.productState', context: context);

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

  late final _$canLoadMoreAtom =
      Atom(name: '_ProductStoreBase.canLoadMore', context: context);

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

  late final _$onlyButtonLoadMoreAtom =
      Atom(name: '_ProductStoreBase.onlyButtonLoadMore', context: context);

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

  late final _$pageAtom =
      Atom(name: '_ProductStoreBase.page', context: context);

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
isCategorySearch: ${isCategorySearch},
productState: ${productState},
canLoadMore: ${canLoadMore},
onlyButtonLoadMore: ${onlyButtonLoadMore},
page: ${page}
    ''';
  }
}
