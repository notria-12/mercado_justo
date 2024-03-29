import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/error.dart';

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

  Future<List<Product>> getProductsByCategory(
      {required String categoryName, required int page}) async {
    try {
      final String name = categoryName.replaceAll(' ', '%20');
      final result = await dio.get(
          '/produtos/category/$name?itens_pagina=15&pagina=$page&ordernar=_id');

      List list = result.data['dados'] as List;
      List<Product> products = list.map((e) => Product.fromMap(e)).toList();
      for (int i = 0; i < products.length; i++) {
        String imagePath = await getProductImage(products[i].barCode.first);
        products[i] = products[i].copyWith(imagePath: imagePath);
      }

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getProductsByDescription(
      {required String description, required int page}) async {
    try {
      final result;
      result = await dio.get(
          "produtos?itens_pagina=15&pagina=$page&ordernar=_id,1&procurar=%5B%7B%22termo%22%3A%22descricao%22%2C%22valor%22%3A%22${description}%22%7D%5D");
      List list = result.data['dados'] as List;
      List<Product> products = list.map((e) => Product.fromMap(e)).toList();
      for (int i = 0; i < products.length; i++) {
        String imagePath = await getProductImage(products[i].barCode.first);
        products[i] = products[i].copyWith(imagePath: imagePath);
      }

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product?> getProductByBarcode({required String barcode}) async {
    try {
      final result;
      result = await dio.get(
          "produtos?itens_pagina=20&pagina=1&ordernar=_id,1&procurar=%5B%7B%22termo%22%3A%22codigo_barras%22%2C%22valor%22%3A%22$barcode%22%7D%5D");
      List list = result.data['dados'] as List;
      if (list.isNotEmpty) {
        Product product = Product.fromMap(list.first);
        String imagePath = await getProductImage(product.barCode[0]);
        return product.copyWith(imagePath: imagePath);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> findOne(String id) async {
    try {
      final result = await dio.get('/produtos/$id');
      return Product.fromMap(result.data['dados']);
    } catch (e) {
      throw Failure(title: 'Erro Produto', message: 'Erro ao buscar produto');
    }
  }

  Future<String> getProductImage(String barCode) async {
    try {
      final result = await dio.get('/imagens/produto/${barCode}');
      if (result.data['dados'] != null) {
        return result.data['dados']['url'];
      } else {
        return '';
      }
    } catch (e) {
      rethrow;
    }
  }
}
