import 'dart:convert';

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

  ObservableList<Product> products = ObservableList.of([]);

  Future getAllProducts() async {
    try {
      products = ObservableList.of(await repository.getAllProducts());
    } catch (e) {
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
