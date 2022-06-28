import 'package:mercado_justo/shared/services/db/db.dart';
import 'package:sqflite/sqflite.dart';

class FairPriceRepository {
  Future saveFairPrice(double value, int listId, int productId) async {
    try {
      Database database = await SQLHelper.init();

      await database.insert('prices',
          {'price': value, 'list_id': listId, 'product_id': productId},
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      rethrow;
    }
  }

  Future<double?> getFairPrice(int listId, int productId) async {
    try {
      Database database = await SQLHelper.init();
      var result = await database.query('prices',
          where: '"list_id" = $listId and "product_id" = $productId');

      if (result.isNotEmpty) {
        return result.first['price'] as double;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateFairPrice(double value, int listId, int productId) async {
    try {
      Database database = await SQLHelper.init();

      await database.update('prices', {'price': value},
          where: '"list_id" = $listId and "product_id" = $productId',
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteFairPrice(int listId, int productId) async {
    try {
      Database database = await SQLHelper.init();
      await database.delete('prices',
          where: '"list_id" = $listId and "product_id" = $productId');
    } catch (e) {
      rethrow;
    }
  }
}
