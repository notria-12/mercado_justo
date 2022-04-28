import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/market_model.dart';

class MarketRepository {
  Dio dio;
  MarketRepository(this.dio);

  Future<List<Market>> getAllMarkets({required int page}) async {
    try {
      final result;

      result = await dio.get('/mercados?pagina=${page}&itens_pagina=5');

      List list = result.data['dados'] as List;
      List<Market> markets = list.map((e) => Market.fromMap(e)).toList();
      for (var i = 0; i < markets.length; i++) {
        String imagePath = await getMarketLogo(markets[i].id);
        markets[i] = markets[i].copyWith(imagePath: imagePath);
      }

      return markets;
    } catch (e) {
      //TODO: tratar esse erro com decência
      rethrow;
    }
  }

  Future<String> getMarketLogo(int id) async {
    try {
      final result = await dio.get('/imagens/logo/${id}');
      return result.data['dados']['url'];
    } catch (e) {
      //TODO: tratar esse erro com decência
      rethrow;
    }
  }
}
