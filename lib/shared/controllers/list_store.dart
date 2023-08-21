import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/price_model.dart';
import 'package:mercado_justo/shared/models/product_list_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/repositories/price_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/list_repository.dart';

part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  final PriceRepository priceRepository;
  final MarketStore marketStore;
  final ListRepository _repository;
  _ListStoreBase(this._repository,
      {required this.priceRepository, required this.marketStore});

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
    if (value == 1 &&
        marketSelected <
            (marketStore.filteredMarkets
                    .where((element) => element.isSelectable == true)
                    .toList()
                    .length -
                1)) {
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

  double getAverageMissingProducts(List<int> productIds) {
    double average = 0;
    List<int> idsByProducts = products.map((e) => e.productId!).toList();
    List<int> newList = productIds.isEmpty
        ? idsByProducts
        : idsByProducts.where((element) {
            return !(productIds.contains(element));
          }).toList();
    if (prices.isNotEmpty) {
      for (var i = 0; i < newList.length; i++) {
        average += prices[products.indexOf(products
                    .firstWhere((element) => element.productId! == newList[i]))]
                .map((e) => _parseToDouble(e))
                .reduce((value, element) => value + element) /
            marketStore.filteredMarkets
                .where((element) => element.isSelectable == true)
                .toList()
                .length;
      }
    }

    return average;
  }

  double getTotalPriceForMyFairPrice(List<Map> productsMap) {
    double total = 0;

    List<int> productIds =
        productsMap.map((e) => e['product_id'] as int).toList();

    if (productIds.isNotEmpty) {
      for (var i = 0; i < productIds.length; i++) {
        int productIndex = products.indexOf(products
            .firstWhere((element) => element.productId! == productIds[i]));
        total += quantities[productIndex] * productsMap[i]['price'] as double;
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
            prices[i][marketSelected] == 'R\$ 0,00' ||
            prices[i][marketSelected] == 'Em Falta') {
          missingItens++;
          average += (prices[i]
                  .map((e) => _parseToDouble(e))
                  .reduce((value, element) => value + element)) /
              marketStore.filteredMarkets
                  .where((element) => element.isSelectable == true)
                  .toList()
                  .length;
        }
      }
    }

    return {
      'missingItens': missingItens,
      'average': average.toStringAsFixed(2)
    };
  }

  double _parseToDouble(String value) {
    return value.isEmpty || value == 'Em Falta'
        ? 0
        : double.parse(value.replaceAll(r'R$ ', '').replaceAll(r',', '.'));
  }

  Future getAllLists() async {
    try {
      listState = AppStateLoading();
      product_list = await _repository.getAllLists();
      listState = AppStateSuccess();
    } catch (e) {
      listState = AppStateError(error: Failure(title: '', message: ''));
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

  Future updateListName({required int listId, required String newName}) async {
    try {
      await _repository.updateListName(listId: listId, newName: newName);
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
      updateQuantityStatus =
          AppStateError(error: Failure(title: '', message: ''));
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

  Future subtractList(
      {required int mainListId,
      required int secondaryLisId,
      required String mainListName}) async {
    try {
      await _repository.subtractList(
          mainListId: mainListId,
          secondaryLisId: secondaryLisId,
          mainListName: mainListName);

      getAllLists();
    } catch (e) {
      rethrow;
    }
  }

  Future duplicateList({required int listId, required String listName}) async {
    try {
      await _repository.duplicateList(listId: listId, listName: listName);
      getAllLists();
    } catch (e) {
      rethrow;
    }
  }

  Future getProducts(int listId) async {
    List<int> auxQuantities = [];

    try {
      List<ProductListModel> listProducts =
          await _repository.getProductsByList(listId);
      products = await _repository
          .getProducts(listProducts.map((e) => e.productId).toList());
      if (products.isNotEmpty) {
        for (Product product in products) {
          auxQuantities
              .add(await _repository.getQuantity(listId, product.productId!));
        }
        quantities = auxQuantities;
        await getProductsPrices();
      }

      productState = AppStateSuccess();
    } catch (e) {
      productState = AppStateError(error: Failure(title: '', message: ''));
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
    try {
      List<List<Price>>? listPricesAux =
          await priceRepository.getProductPricesByMarkets(
              productIds: products.map((e) => e.id).toList(),
              marketIds: marketStore.filteredMarkets
                  .where((element) => element.isSelectable == true)
                  .map((e) => e.id)
                  .toList());

      prices = listPricesAux!
          .map((element) => element.map((e) => e.price).toList())
          .toList();
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
