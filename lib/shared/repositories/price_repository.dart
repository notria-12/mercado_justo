import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/price_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/error.dart';

class PriceRepository {
  Dio dio;

  PriceRepository({
    required this.dio,
  });

  Future<Price> getProductPriceByMarket(
      {required marketId, required String barCode}) async {
    try {
      var result = await dio.get(
          "precos?procurar=%5B%7B%22termo%22%3A%22id%22%2C%22valor%22%3A${marketId}%2C%22tipo%22%3A%22number%22%2C%22estrito%22%3Atrue%7D%2C%7B%22termo%22%3A%22codigo_barras%22%2C%22valor%22%3A%22${barCode}%22%2C%22estrito%22%3Atrue%7D%5D");
      List prices = result.data['dados'] as List;
      if (prices.isEmpty) {
        return Price(
            id: 'id',
            idMarket: 0,
            price: '',
            updateAt: '',
            product: Product(description: '', barCode: [], id: ''));
      } else {
        return prices
            .map(
              (e) => Price.fromMap(e),
            )
            .first;
      }
    } catch (e) {
      //TODO
      rethrow;
    }
  }

  Future<List<List<Price>>?> getProductPricesByMarkets(
      {required List<String> productIds, required List<int> marketIds}) async {
    try {
      String ids =
          marketIds.toString().replaceAll('[', "").replaceAll(']', "").trim();
      String products = productIds
          .toString()
          .replaceAll('[', "")
          .replaceAll(']', "")
          .replaceAll(' ', "");
      var result = await dio
          .get('precos/specifics-prices?productIds=$products&marketIds=$ids');
      List pricesAux = result.data['dados'] as List;
      // var pricesByProducts = pricesAux;
      List<List<Price>> prices = pricesAux
          .map((element) => (element as List).map((e) {
                return Price.fromMap(e);
              }).toList())
          .toList();

      return prices;
    } catch (e) {
      Failure(
          message: 'Não foi possível listar os preços', title: 'Erro preços');
    }
  }
}
