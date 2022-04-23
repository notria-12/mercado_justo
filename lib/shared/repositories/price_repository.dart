import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/price_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';

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
      return prices
          .map(
            (e) => Price.fromMap(e),
          )
          .first;
    } catch (e) {
      //TODO
      rethrow;
    }
  }
}
