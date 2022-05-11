import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/services/db/db.dart';
import 'package:sqflite/sqflite.dart';

class ListRepository {
  Future createList(ListModel list) async {
    try {
      //TODO pensar forma de injetar dependência de SQLHelper
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
}
