import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/utils/error.dart';

class AveragePriceRepository {
  Dio _dio;
  AveragePriceRepository(this._dio);

  Future<double> getAveragePrice(
      {required String productId, required List<int> marketIds}) async {
    try {
      String ids =
          marketIds.toString().replaceAll('[', "").replaceAll(']', "").trim();
      var result = await _dio
          .get('precos/preco-medio?productId=$productId&marketIds=$ids');
      return result.data['dados']['preco-medio'] as double;
    } catch (e) {
      throw Failure(
          title: 'Preço médio', message: 'Erro ao calcular preço médio');
    }
  }
}
