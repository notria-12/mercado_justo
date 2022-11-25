// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:mercado_justo/app/modules/home_auth/models/category_model.dart';
import 'package:mercado_justo/shared/utils/error.dart';

class CategoryRepository {
  Dio _dio;
  CategoryRepository(
    this._dio,
  );

  Future<List<CategoryModel>> getMainCategories() async {
    try {
      var result = await _dio.get('/categorias/geral');
      return (result.data['dados'] as List)
          .map((e) => CategoryModel.fromMap(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getSecondaryCategories(String categoryId) async {
    try {
      var result = await _dio.get('/categorias/geral/$categoryId');
      return (result.data['dados'] as List)
          .map((e) => CategoryModel.fromMap(e))
          .toList();
    } catch (e) {
      throw Failure(
          title: 'Erro categorias', message: 'Erro ao carregar categorias');
    }
  }
}
