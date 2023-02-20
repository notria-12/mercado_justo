import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/app/modules/lists/filter_store.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/repositories/market_repository.dart';
import 'package:mobx/mobx.dart';

part 'market_store.g.dart';

class MarketStore = _MarketStoreBase with _$MarketStore;

abstract class _MarketStoreBase with Store {
  MarketRepository repository;
  PositionStore positionStore;
  FilterStore filterStore;
  _MarketStoreBase({
    required this.repository,
    required this.positionStore,
    required this.filterStore,
  });

  @observable
  List<Market> markets = [];

  @observable
  List<List<Market>> groupMarkets = [];

  @observable
  int page = 1;

  @observable
  String? marketId;

  Future getGroupMarkets() async {
    try {
      groupMarkets = await repository.getGroupMarkets();

      setMarkets();
    } catch (e) {
      rethrow;
    }
  }

  void setMarkets() {
    markets = groupMarkets.map((e) => getShorterDistance(e)).toList();
    markets.sort((a, b) => a.id - b.id);
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

  @computed
  List<Market> get filteredMarkets {
    List<Market> newMarkets = markets
        .where((market) =>
            (Geolocator.distanceBetween(
                    positionStore.position!.latitude,
                    positionStore.position!.longitude,
                    market.latitude,
                    market.longitude) /
                1000) <
            filterStore.rating)
        .toList();
    if (marketId != null && marketId != '') {
      newMarkets = newMarkets.map((e) {
        if (e.hashId == marketId) {
          return e.copyWith(isSelectable: !e.isSelectable);
        }
        return e;
      }).toList();
      int index = markets.indexWhere((element) => element.hashId == marketId);
      markets[index] = markets
          .elementAt(index)
          .copyWith(isSelectable: !markets.elementAt(index).isSelectable);
    }
    return newMarkets;
  }

  Future<Market> findOne(String id) async {
    try {
      return repository.finOne(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getMarketImage({required int id}) async {
    try {
      return await repository.getMarketLogo(id);
    } catch (e) {
      rethrow;
    }
  }

  List<Market> getMarketsByName(String name) {
    return groupMarkets.firstWhere((element) => element[0].name == name);
  }
}
