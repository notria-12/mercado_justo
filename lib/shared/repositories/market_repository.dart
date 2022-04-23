import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/market_model.dart';

class MarketRepository {
  Dio dio;
  MarketRepository(this.dio);

  Future<List<Market>> getAllMarkets({required int page}) async {
    try {
      final result;

      result = await dio.get('/mercados?pagina=${page}&itens_pagina=2');

      List list = result.data['dados'] as List;

      return list.map((e) => Market.fromMap(e)).toList();
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
