import 'package:mercado_justo/app/modules/home/repositories/initial_repository.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

part 'initial_controller.g.dart';

class InitialStore = InitialStoreBase with _$InitialStore;

abstract class InitialStoreBase with Store {
  final InitialRepository _repository;

  InitialStoreBase(this._repository);

  ObservableList<Product> products = ObservableList.of([]);
  ObservableList<Market> markets = ObservableList.of([]);

  @observable
  AppState productState = AppStateEmpty();
  @observable
  AppState marketState = AppStateEmpty();
  @observable
  AppState allPriceStatus = AppStateEmpty();

  @observable
  List<List<Market>> groupMarkets = [];
  @observable
  List<List<String>> prices = [];

  getPublicsProducts() async {
    try {
      productState = AppStateLoading();
      List<Product> productsList = await _repository.getProducts();
      products = ObservableList.of(productsList);
      productState = AppStateSuccess();
    } on Failure catch (e) {
      productState = AppStateError(error: e);
    }
  }

  getPublicMarkets() async {
    try {
      marketState = AppStateLoading();
      List<Market> marketList = await _repository.getMarkets();
      for (int i = 0; i < marketList.length; i++) {
        Market market = marketList[i];
        if (groupMarkets.isEmpty) {
          groupMarkets.add([market]);
        } else {
          bool contains = false;
          for (var j = 0; j < groupMarkets.length; j++) {
            if (groupMarkets[j].contains(market)) {
              groupMarkets[j].add(market);
              contains = true;
              break;
            }
          }
          if (!contains) {
            groupMarkets.add([market]);
          }
        }
      }
      markets = ObservableList.of(groupMarkets.map((e) => e[0]));
      marketState = AppStateSuccess();
    } on Failure catch (e) {
      marketState = AppStateError(error: e);
    }
  }

  Future<void> getProductPriceByMarkets(
      {required List<String> productIds, required List<int> marketIds}) async {
    try {
      allPriceStatus = AppStateLoading();
      var pricesAux = await _repository.getProductPricesByMarkets(
          productIds: productIds, marketIds: marketIds);
      prices = pricesAux!
          .map((element) => element.map((e) => e.price).toList())
          .toList();
      allPriceStatus = AppStateSuccess();
    } on Failure catch (e) {
      allPriceStatus = AppStateError(error: e);
    }
  }

  List<Market> getMarketsByName(String name) {
    return groupMarkets.firstWhere((element) => element[0].name == name);
  }
}
