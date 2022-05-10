import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/services/db/db.dart';
import 'package:sqflite/sqflite.dart';

class ListRepository {
  Future createList(ListModel list) async {
    try {
      //TODO pensar forma de injetar dependência de SQLHelper
      Database database = await SQLHelper.init();

      int id = await database.insert('lists', list.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print(id);
    } catch (e) {
      rethrow;
    }
  }
}
