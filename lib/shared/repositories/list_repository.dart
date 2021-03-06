import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/models/product_list_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/services/db/db.dart';
import 'package:sqflite/sqflite.dart';

class ListRepository {
  Future createList(ListModel list) async {
    try {
      //TODO pensar forma de injetar dependĂȘncia de SQLHelper
      Database database = await SQLHelper.init();

      await database.insert('lists', list.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ListModel>> getAllLists() async {
    try {
      Database database = await SQLHelper.init();

      final result = await database.query(
        'lists',
      );

      return result.map((e) => ListModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductListModel>> getProductsByList(int listId) async {
    try {
      Database database = await SQLHelper.init();
      final result =
          await database.query('list_products', where: '"list_id" = $listId');

      return result.map((e) => ProductListModel.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getProducts(List<int> productIds) async {
    try {
      Database database = await SQLHelper.init();
      final result = await database.query('products',
          where:
              '"id" in $productIds'.replaceAll('[', '(').replaceAll(']', ')'));
      return result.map((e) => Product.fromMapSQL(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future deleteList(int listId) async {
    try {
      Database database = await SQLHelper.init();
      await database.delete('list_products', where: '"list_id" = $listId');
      await database.delete('lists', where: '"id" = $listId');
    } catch (e) {
      rethrow;
    }
  }

  Future deleteProductOfList(int listId, int productId) async {
    try {
      Database database = await SQLHelper.init();
      await database.delete('list_products',
          where: '"list_id" = $listId and "product_id" = $productId');
    } catch (e) {
      rethrow;
    }
  }

  Future updateQuantity(int listId, int productId, int newQuantity) async {
    try {
      Database database = await SQLHelper.init();
      await database.update('list_products', {'quantity': newQuantity},
          where: '"list_id" = $listId and "product_id" = $productId');
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getQuantity(int listId, int productId) async {
    try {
      Database database = await SQLHelper.init();
      final result = await database.query('list_products',
          where: '"product_id" = $productId and "list_id" = $listId');
      return ProductListModel.fromMap(result.first).quantity;
    } catch (e) {
      rethrow;
    }
  }
}
