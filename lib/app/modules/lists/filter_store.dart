// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';

part 'filter_store.g.dart';

class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {
  PositionStore positionStore;

  _FilterStoreBase({
    required this.positionStore,
  });

  @observable
  double rating = 100;

  @observable
  String? marketId;

  @observable
  List<Market> markets = [];

  @action
  setMarkets(List<Market> newMarkets) {
    markets = newMarkets;
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
            rating)
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
}
