import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/models/price_model.dart';
import 'package:mercado_justo/shared/models/product_list_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/repositories/list_repository.dart';
import 'package:mercado_justo/shared/repositories/price_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'compare_store.g.dart';

class CompareStore = _CompareStoreBase with _$CompareStore;

abstract class _CompareStoreBase with Store {
  ListRepository repository;
  final PriceRepository priceRepository;

  final MarketStore marketStore;
  _CompareStoreBase({
    required this.repository,
    required this.priceRepository,
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

  @observable
  List<Product> products = [];

  @observable
  AppState productState = AppStateEmpty();

  @observable
  List<int> quantities = [];

  @observable
  int missingItens = 0;

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

  Future getProducts(int listId) async {
    List<int> auxQuantities = [];
    
    productState = AppStateLoading();
    try {
      List<ProductListModel> listProducts =
          await repository.getProductsByList(listId);
      products = await repository
          .getProducts(listProducts.map((e) => e.productId).toList());
      if (products.isNotEmpty) {
        for (Product product in products) {
          auxQuantities
              .add(await repository.getQuantity(listId, product.productId!));
        }
        quantities = auxQuantities;
      }

      productState = AppStateSuccess();
    } catch (e) {
      productState = AppStateError(error: Failure(title: '', message: ''));
      rethrow;
    }
  }

  Future getProductsPrices(List<Product> products) async {
    List<List<Map<String, dynamic>>> listPricesAux = [];
   
    try {
      List<List<Price>>? pricesAux =
          await priceRepository.getProductPricesByMarkets(
              productIds: products.map((e) => e.id).toList(),
              marketIds: marketStore.filteredMarkets
                  .where(
                    (element) => element.isSelectable,
                  )
                  .map((e) => e.id)
                  .toList());
                  
      for (int i = 0; i < pricesAux!.length; i++) {
        List<Map<String, dynamic>> pricesByProducts = [];
        for (Price currentPrice in pricesAux[i]) {
          int quantity = await getQuantity(listId!, products[i].productId!);
          String marketId = marketStore.filteredMarkets
              .where(
                (element) => element.isSelectable,
              )
              .firstWhere((element) => element.id == currentPrice.idMarket,
                  orElse: () => marketStore.filteredMarkets[0])
              .hashId;
          pricesByProducts.add({
            "market_id": marketId,
            "value": currentPrice.price,
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

  @action
  setMissingProducts(List<List<Map<String, dynamic>>> fairPrices){
    missingItens = 0;
     fairPrices.forEach((element) {
      
      element.forEach((e) {
        if(e['value'] == 0.0){
          missingItens++;
        }
        
      });
    });
  }

  double _parseToDouble(String value) => value.isEmpty || value == 'Em Falta'
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
