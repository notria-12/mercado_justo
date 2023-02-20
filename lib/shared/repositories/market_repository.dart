import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/utils/error.dart';

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

  Future<Market> finOne(String id) async {
    try {
      final result = await dio.get('/mercados/$id');
      return Market.fromMap(result.data['dados']);
    } catch (e) {
      throw Failure(title: 'Buscar mercado', message: 'Erro ao buscar mercado');
    }
  }

  Future<List<List<Market>>> getGroupMarkets() async {
    try {
      List<List<Market>> listMarkets = [];
      final result;

      result = await dio.get('/mercados/listar');
      List list = result.data['dados'] as List;
      for (var item in list) {
        var response = await dio.get(
            'mercados?itens_pagina=20&pagina=1&ordernar=_id,1&procurar=%5B%7B%22termo%22%3A%22nome%22%2C%22valor%22%3A%22${item['value']}%22%7D%5D');
        List mapMarkets = response.data['dados'] as List;
        List<Market> markets =
            mapMarkets.map((e) => Market.fromMap(e)).toList();
        listMarkets.add(markets);
      }
      for (var i = 0; i < listMarkets.length; i++) {
        String imagePath = await getMarketLogo(listMarkets[i][0].id);
        listMarkets[i] = listMarkets[i]
            .map((e) => e.copyWith(imagePath: imagePath))
            .toList();
      }
      return listMarkets;
    } catch (e) {
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
