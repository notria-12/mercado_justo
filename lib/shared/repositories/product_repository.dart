import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/product_model.dart';

class ProductRepository {
  Dio dio;

  ProductRepository({
    required this.dio,
  });

  Future<List<Product>> getAllProducts() async {
    try {
      final result = await dio.get('/produtos/');
      List list = result.data['dados'] as List;

      return list.map((e) => Product.fromMap(e)).toList();
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
