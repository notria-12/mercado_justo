import 'package:mercado_justo/shared/services/db/db.dart';
import 'package:sqflite/sqflite.dart';

class NameMarketRepository {
  Future saveMarketName(String name, int listId) async {
    try {
      Database database = await SQLHelper.init();

      await database.insert('names_markets', {'name': name, 'list_id': listId});
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getMarketName(int listId) async {
    try {
      Database database = await SQLHelper.init();

      var result =
          await database.query('names_markets', where: '"list_id" = $listId');

      if (result.isNotEmpty) {
        return result.first['name'] as String;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateMarketName(String name, int listId) async {
    try {
      Database database = await SQLHelper.init();
      await database.update('names_markets', {'name': name},
          where: '"list_id" = $listId');
    } catch (e) {
      rethrow;
    }
  }

  Future deleteMarketName(int listId) async {
    try {
      Database database = await SQLHelper.init();
      await database.delete('names_markets', where: '"list_id" = $listId');
    } catch (e) {
      rethrow;
    }
  }
}
