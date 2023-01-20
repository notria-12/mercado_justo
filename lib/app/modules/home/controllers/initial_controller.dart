import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/app/modules/home/repositories/initial_repository.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/controllers/position_store.dart';

part 'initial_controller.g.dart';

class InitialStore = InitialStoreBase with _$InitialStore;

abstract class InitialStoreBase with Store {
  final InitialRepository _repository;
  final PositionStore positionStore;

  InitialStoreBase(this._repository, this.positionStore);

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
      List<Market> auxMarkets = groupMarkets
          .map((e) => getShorterDistance(e))
          .where((market) =>
              (Geolocator.distanceBetween(
                      positionStore.position!.latitude,
                      positionStore.position!.longitude,
                      market.latitude,
                      market.longitude) /
                  1000) <
              101)
          .toList();
      markets = ObservableList.of(auxMarkets);
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

  Market getShorterDistance(List<Market> markets) {
    Market closerMarket = markets[0];

    for (int i = 1; i < markets.length; i++) {
      double currentDistance = Geolocator.distanceBetween(
          positionStore.position!.latitude,
          positionStore.position!.longitude,
          closerMarket.latitude,
          closerMarket.longitude);
      if (currentDistance >
          Geolocator.distanceBetween(
              positionStore.position!.latitude,
              positionStore.position!.longitude,
              markets[i].latitude,
              markets[i].longitude)) {
        closerMarket = markets[i];
      }
    }

    return closerMarket;
  }

  List<Market> getMarketsByName(String name) {
    return groupMarkets.firstWhere((element) => element[0].name == name);
  }
}
