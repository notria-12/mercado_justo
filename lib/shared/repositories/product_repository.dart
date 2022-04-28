import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/product_model.dart';

class ProductRepository {
  Dio dio;

  ProductRepository({
    required this.dio,
  });

  Future<List<Product>> getAllProducts({required int page}) async {
    try {
      final result;

      result = await dio.get('/produtos?pagina=${page}&itens_pagina=15');

      List list = result.data['dados'] as List;
      List<Product> products = list.map((e) => Product.fromMap(e)).toList();
      for (int i = 0; i < products.length; i++) {
        String imagePath = await getProductImage(products[i].barCode.first);
        products[i] = products[i].copyWith(imagePath: imagePath);
      }

      return products;
    } catch (e) {
      //TODO: tratar esse erro com decência
      rethrow;
    }
  }

  Future<String> getProductImage(String barCode) async {
    try {
      final result = await dio.get('/imagens/produto/${barCode}');
      return result.data['dados']['url'];
    } catch (e) {
      rethrow;
    }
  }
}
