import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/services/db/db.dart';
import 'package:sqflite/sqflite.dart';

class ProductToListRepository {
  Future<int> addProduct(Product product) async {
    try {
      //TODO pensar forma de injetar dependência de SQLHelper
      Database database = await SQLHelper.init();

      int id = await database.insert('products', product.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      return id;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product?> findOne(String barCode) async {
    try {
      //TODO pensar forma de injetar dependência de SQLHelper
      Database database = await SQLHelper.init();

      final result =
          await database.query('products', where: '"bar_code" = $barCode');
      if (result.isEmpty) {
        return null;
      } else {
        return Product.fromMapSQL(result.first);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addToList(
      {required int productId,
      required int listId,
      required int quantity}) async {
    try {
      //TODO pensar forma de injetar dependência de SQLHelper
      Database database = await SQLHelper.init();

      await database.insert('list_products',
          {'product_id': productId, 'list_id': listId, 'quantity': quantity},
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      rethrow;
    }
  }
}
