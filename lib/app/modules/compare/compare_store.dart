import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/repositories/list_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'compare_store.g.dart';

class CompareStore = _CompareStoreBase with _$CompareStore;

abstract class _CompareStoreBase with Store {
  ListRepository repository;
  final PriceStore priceStore;
  final MarketStore marketStore;
  _CompareStoreBase({
    required this.repository,
    required this.priceStore,
    required this.marketStore,
  });

  @observable
  int? newQuantity;

  @observable
  List<List<Map<String, dynamic>>> prices = [];

  @observable
  int? listId;

  @observable
  double total = 0;

  @observable
  List<Map<String, dynamic>> listTotal = [];

  @action
  setTotal(double value) => total = value;

  Future<int> getQuantity(int listId, int productId) async {
    return repository.getQuantity(listId, productId);
  }

  Future updateQuantity(int productId) async {
    await repository.updateQuantity(listId!, productId, newQuantity!);
    reloadList();
  }

  Future removeProductFromList(int productId) async {
    await repository.deleteProductOfList(listId!, productId);
    reloadList();
  }

  reloadList() {
    int auxListId = listId!;
    listId = null;
    prices = [];
    listId = auxListId;
  }

  @action
  setListTotal(Map<String, dynamic> value) => listTotal = [...listTotal, value];

  Future getProductsPrices(List<Product> products) async {
    List<List<Map<String, dynamic>>> listPricesAux = [];

    try {
      for (int i = 0; i < products.length; i++) {
        List<Map<String, dynamic>> pricesByProducts = [];
        for (Market market in marketStore.filteredMarkets) {
          String? price = await priceStore.getProductPriceByMarket(
              marketId: market.id, barCode: products[i].barCode.first);
          int quantity = await getQuantity(listId!, products[i].productId!);
          pricesByProducts.add({
            "market_id": market.hashId,
            "value": price,
            "product_id": products[i].toMap(),
            "quantity": quantity
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
                  'value': _parseToDouble(e['value']!),
                  'quantity': e['quantity']
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
    } else {
      groupFairPrices = [];
    }
    return groupFairPrices;
  }

  List<List<Product>> groupProducts(List<Product> products) {
    List<List<Product>> groupProducts = [];
    for (int i = 0; i < products.length; i++) {
      String category = products[i].category!;
      if (!products
          .map((product) => product.category)
          .toList()
          .sublist(0, i)
          .contains(category)) {
        groupProducts
            .add(products.where((item) => item.category == category).toList());
      }
    }
    double sum = 0;
    getFairPrice.forEach((element) {
      sum += element.map((e) {
        return e['value'] * e['quantity'] as double;
      }).reduce((value, element) => value + element);
    });
    setTotal(sum);
    return groupProducts;
  }

  double _parseToDouble(String value) => value.isEmpty
      ? 0
      : double.parse(value.replaceAll(r'R$ ', '').replaceAll(r',', '.'));

  Future addToComparePage(int listId) async {
    final sharedPrefences = await SharedPreferences.getInstance();

    sharedPrefences.setInt('current_list', listId);
    this.listId = listId;
  }

  Future<int?> getCurrentList() async {
    final sharedPrefences = await SharedPreferences.getInstance();
    if (sharedPrefences.containsKey('current_list')) {
      int id = sharedPrefences.getInt('current_list')!;
      listId = id;
      return id;
    }
  }

  Future removeListInComparePage() async {
    final sharedPrefences = await SharedPreferences.getInstance();
    listId = null;
    total = 0.0;
    prices = [];
    sharedPrefences.remove('current_list');
  }
}
