import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/app/modules/lists/filter_store.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/repositories/market_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/utils.dart';

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

  Future getAllMarkets() async {
    try {
      List<Market> auxMarkets = await repository.getAllMarkets(page: page);
      markets = [...markets, ...auxMarkets];
      page++;
    } catch (e) {
      rethrow;
    }
  }

  Future getGroupMarkets() async {
    try {
      groupMarkets = await repository.getGroupMarkets();

      markets = groupMarkets.map((e) => e[0]).toList();
    } catch (e) {
      rethrow;
    }
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
