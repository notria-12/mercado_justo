// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/price_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/error.dart';

class InitialRepository {
  final Dio _dio;
  InitialRepository(
    this._dio,
  );

  Future<List<Market>> getMarkets() async {
    try {
      var result = await _dio.get('mercados-publicos');
      List<Market> markets =
          (result.data['dados'] as List).map((e) => Market.fromMap(e)).toList();
      for (var i = 0; i < markets.length; i++) {
        String imagePath = await getMarketLogo(markets[i].id);
        markets[i] = markets[i].copyWith(imagePath: imagePath);
      }
      return markets;
    } catch (e) {
      throw Failure(message: 'Erro ao buscar mercados', title: 'Erro mercados');
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
      var result =
          await _dio.get('precos-publicos?productIds=$products&marketIds=$ids');
      List pricesAux = result.data['dados'] as List;

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

  Future<List<Product>> getProducts() async {
    try {
      var result = await _dio.get('produtos-publicos');
      List<Product> products = (result.data['dados'] as List)
          .map((e) => Product.fromMap(e))
          .toList();
      for (int i = 0; i < products.length; i++) {
        String imagePath = await getProductImage(products[i].barCode.first);
        products[i] = products[i].copyWith(imagePath: imagePath);
      }
      return products;
    } catch (e) {
      throw Failure(title: 'Erro ao buscar produtos', message: 'Erro produtos');
    }
  }

  Future<String> getProductImage(String barCode) async {
    try {
      final result = await _dio.get('/imagens/produto/${barCode}');
      if (result.data['dados'] != null) {
        return result.data['dados']['url'];
      } else {
        return '';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getMarketLogo(int id) async {
    try {
      final result = await _dio.get('/imagens/logo/${id}');
      return result.data['dados']['url'];
    } catch (e) {
      //TODO: tratar esse erro com decência
      rethrow;
    }
  }
}
