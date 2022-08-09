import 'package:mercado_justo/shared/repositories/price_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

part 'price_store.g.dart';

class PriceStore = _PriceStoreBase with _$PriceStore;

abstract class _PriceStoreBase with Store {
  PriceRepository repository;
  _PriceStoreBase({
    required this.repository,
  });

  @override
  AppState priceStatus = AppStateEmpty();

  Future<String> getProductPriceByMarket(
      {required int marketId, required String barCode}) async {
    try {
      priceStatus = AppStateLoading();
      final price = await repository.getProductPriceByMarket(
          marketId: marketId, barCode: barCode);
      priceStatus = AppStateSuccess();
      return price.price;
    } catch (e) {
      priceStatus = AppStateError(error: Failure(title: '', message: ''));
      rethrow;
    }
  }
}
