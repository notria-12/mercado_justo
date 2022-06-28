import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/product_to_list_repository.dart';

part 'product_to_list_store.g.dart';

class ProductToListStore = _ProductToListStoreBase with _$ProductToListStore;

abstract class _ProductToListStoreBase with Store {
  ProductToListRepository _repository;
  _ProductToListStoreBase(
    this._repository,
  );

  @observable
  int? productId;

  @observable
  int value = 1;

  @action
  void increment() {
    value++;
  }

  @action
  void decrement() {
    value--;
  }

  Future saveProduct(Product product) async {
    try {
      Product? currentProduct =
          await _repository.findOne(product.barCode.first);

      if (currentProduct == null) {
        productId = await _repository.addProduct(product);
      } else {
        productId = currentProduct.productId!;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addToList({required listId}) async {
    try {
      await _repository.addToList(
          productId: productId!, listId: listId, quantity: value);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getQuantity({required int listId, required int productId}) async {
    try {
      return _repository.getQuantity(listId, productId);
    } catch (e) {
      rethrow;
    }
  }
}
