import 'dart:convert';

import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/repositories/product_repository.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStoreBase with _$ProductStore;

abstract class _ProductStoreBase with Store {
  ProductRepository repository;
  _ProductStoreBase({
    required this.repository,
  });
  @observable
  List<Product> products = [];

  @observable
  AppState productState = AppStateEmpty();

  @observable
  int page = 1;

  Future getAllProducts() async {
    try {
      productState = AppStateLoading();
      products = [...products, ...await repository.getAllProducts(page: page)];
      page++;
      productState = AppStateSuccess();
    } catch (e) {
      productState = AppStateError();
      rethrow;
    }
  }

  Future<String> getProductImage({required String barCode}) async {
    try {
      return await repository.getProductImage(barCode);
    } catch (e) {
      rethrow;
    }
  }
}
