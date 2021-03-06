import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_list_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/list_repository.dart';

part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  final PriceStore priceStore;
  final MarketStore marketStore;
  final ListRepository _repository;
  _ListStoreBase(this._repository,
      {required this.priceStore, required this.marketStore});

  @observable
  List<ListModel> product_list = [];

  @observable
  bool isFairPrice = false;

  @observable
  List<Product> products = [];

  @observable
  List<List<String>> prices = [];

  @observable
  List<int> quantities = [];

  @observable
  int marketSelected = 0;

  @observable
  AppState listState = AppStateEmpty();

  @observable
  AppState productState = AppStateEmpty();

  @observable
  AppState priceState = AppStateEmpty();

  @observable
  AppState updateQuantityStatus = AppStateEmpty();

  @action
  void setMarketSelected(int value) {
    if (value == -1 && marketSelected > 0 ||
        (value == -1 && marketSelected >= 0 && isFairPrice)) {
      marketSelected--;
    }
    if (value == 1 && marketSelected < (marketStore.markets.length - 1)) {
      marketSelected++;
    }
  }

  Future createNewList(String name) async {
    try {
      ListModel listModel = ListModel(name: name);
      await _repository.createList(listModel);
      getAllLists();
    } catch (e) {
      rethrow;
    }
  }

  @computed
  double get totalPrice {
    double total = 0;
    if (marketSelected >= 0) {
      for (var i = 0; i < prices.length; i++) {
        total += (_parseToDouble(prices[i][marketSelected]) * quantities[i]);
      }
    }
    return total;
  }

  @computed
  Map<String, dynamic> get missingProducts {
    int missingItens = 0;
    double average = 0;
    if (marketSelected >= 0) {
      for (var i = 0; i < prices.length; i++) {
        if (prices[i][marketSelected].isEmpty ||
            prices[i][marketSelected] == 'R\$ 0,00') {
          missingItens++;
          average += (prices[i]
                  .map((e) => _parseToDouble(e))
                  .reduce((value, element) => value + element)) /
              marketStore.markets.length;
        }
      }
    }

    return {
      'missingItens': missingItens,
      'average': average.toStringAsFixed(2)
    };
  }

  double _parseToDouble(String value) => value.isEmpty
      ? 0
      : double.parse(value.replaceAll(r'R$ ', '').replaceAll(r',', '.'));

  Future getAllLists() async {
    try {
      listState = AppStateLoading();
      product_list = await _repository.getAllLists();
      listState = AppStateSuccess();
    } catch (e) {
      listState = AppStateError();
      rethrow;
    }
  }

  Future deleteProductOfList(
      {required int listId, required int productId}) async {
    try {
      await _repository.deleteProductOfList(listId, productId);
      prices = [];

      getProducts(listId);
      getAllLists();
    } catch (e) {
      rethrow;
    }
  }

  Future updateQuantity(int listId) async {
    updateQuantityStatus = AppStateLoading();
    try {
      for (var i = 0; i < products.length; i++) {
        await _repository.updateQuantity(
            listId, products[i].productId!, quantities[i]);
      }
      prices = [];
      getProducts(listId);
      updateQuantityStatus = AppStateSuccess();
      Modular.to.pop();
      prices = [];
    } catch (e) {
      updateQuantityStatus = AppStateError();
      rethrow;
    }
  }

  Future<int> getProductsByList(int listId) async {
    try {
      List<ProductListModel> list_products =
          await _repository.getProductsByList(listId);
      return list_products.length;
    } catch (e) {
      rethrow;
    }
  }

  Future getProducts(int listId) async {
    List<int> auxQuantities = [];
    try {
      productState = AppStateLoading();
      List<ProductListModel> list_products =
          await _repository.getProductsByList(listId);
      products = await _repository
          .getProducts(list_products.map((e) => e.productId).toList());
      for (Product product in products) {
        auxQuantities
            .add(await _repository.getQuantity(listId, product.productId!));
      }
      quantities = auxQuantities;
      getProductsPrices();
      productState = AppStateSuccess();
    } catch (e) {
      productState = AppStateError();
      rethrow;
    }
  }

  @computed
  List<List<Product>> get groupProducts {
    List<List<Product>> groupProducts = [];
    for (int i = 0; i < products.length; i++) {
      String category = products[i].category2!;
      if (!products
          .map((product) => product.category2)
          .toList()
          .sublist(0, i)
          .contains(category)) {
        groupProducts
            .add(products.where((item) => item.category2 == category).toList());
      }
    }
    return groupProducts;
  }

  Future getProductsPrices() async {
    List<List<String>> listPricesAux = [];

    try {
      for (int i = 0; i < products.length; i++) {
        List<String> pricesByProducts = [];
        for (Market market in marketStore.markets) {
          String? price = await priceStore.getProductPriceByMarket(
              marketId: market.id, barCode: products[i].barCode.first);
          pricesByProducts.add(price);
        }
        listPricesAux.add([...pricesByProducts]);
      }
      prices = listPricesAux;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteList(int listId) async {
    try {
      await _repository.deleteList(listId);
      getAllLists();
    } catch (e) {
      rethrow;
    }
  }
}
