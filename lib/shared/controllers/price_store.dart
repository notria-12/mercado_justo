import 'package:mercado_justo/shared/repositories/price_repository.dart';
import 'package:mobx/mobx.dart';

part 'price_store.g.dart';

class PriceStore = _PriceStoreBase with _$PriceStore;

abstract class _PriceStoreBase with Store {
  PriceRepository repository;
  _PriceStoreBase({
    required this.repository,
  });

  Future<String> getProductPriceByMarket(
      {required int marketId, required String barCode}) async {
    try {
      final price = await repository.getProductPriceByMarket(
          marketId: marketId, barCode: barCode);
      return price.price;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
