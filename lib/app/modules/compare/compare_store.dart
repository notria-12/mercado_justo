import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';

part 'compare_store.g.dart';

class CompareStore = _CompareStoreBase with _$CompareStore;

abstract class _CompareStoreBase with Store {
  final PriceStore priceStore;
  final MarketStore marketStore;
  _CompareStoreBase({
    required this.priceStore,
    required this.marketStore,
  });

  @observable
  List<List<Map<String, dynamic>>> prices = [];

  Future getProductsPrices(List<Product> products) async {
    List<List<Map<String, dynamic>>> listPricesAux = [];

    try {
      for (int i = 0; i < products.length; i++) {
        List<Map<String, dynamic>> pricesByProducts = [];
        for (Market market in marketStore.markets) {
          String? price = await priceStore.getProductPriceByMarket(
              marketId: market.id, barCode: products[i].barCode.first);
          pricesByProducts.add({
            "market_id": market.hashId,
            "value": price,
            "product_id": products[i].toMap()
          });
        }
        listPricesAux.add([...pricesByProducts]);
      }
      prices = listPricesAux;
    } catch (e) {
      rethrow;
    }
  }

  @computed
  List<List<Map<String, dynamic>>> get getFairPrice {
    List<Map<String, dynamic>> fairPrices = [];
    List<List<Map<String, dynamic>>> groupFairPrices = [];
    if (prices.isNotEmpty) {
      for (int i = 0; i < prices.length; i++) {
        var map = prices[i]
            .map((e) => <String, dynamic>{
                  'market_id': e['market_id'],
                  'product_id': e['product_id'],
                  'value': _parseToDouble(e['value']!)
                })
            .reduce((value, element) => (value['value']! > element['value']! &&
                        element['value'] != 0) ||
                    value['value'] == 0
                ? element
                : value);
        fairPrices.add(map);
      }

      for (int i = 0; i < fairPrices.length; i++) {
        String marketId = fairPrices[i]['market_id']!;
        if (!fairPrices
            .map((price) => price['market_id'])
            .toList()
            .sublist(0, i)
            .contains(marketId)) {
          groupFairPrices.add(fairPrices
              .where((item) => item['market_id']! == marketId)
              .toList());
        }
      }
    }
    return groupFairPrices;
  }

  List<List<Product>> groupProducts(List<Product> products) {
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

  double _parseToDouble(String value) => value.isEmpty
      ? 0
      : double.parse(value.replaceAll(r'R$ ', '').replaceAll(r',', '.'));

  Future addToComparePage(int listId) async {
    final sharedPrefences = await SharedPreferences.getInstance();

    sharedPrefences.setInt('current_list', listId);
  }

  Future<int?> getCurrentList() async {
    final sharedPrefences = await SharedPreferences.getInstance();
    if (sharedPrefences.containsKey('current_list')) {
      return sharedPrefences.getInt('current_list')!;
    }
  }
}
