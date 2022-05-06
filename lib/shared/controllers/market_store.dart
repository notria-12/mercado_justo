import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/repositories/market_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/utils.dart';
import 'package:mobx/mobx.dart';

part 'market_store.g.dart';

class MarketStore = _MarketStoreBase with _$MarketStore;

abstract class _MarketStoreBase with Store {
  MarketRepository repository;
  _MarketStoreBase({
    required this.repository,
  });

  @observable
  List<Market> markets = [];

  @observable
  List<List<Market>> groupMarkets = [];

  @observable
  int page = 1;

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
