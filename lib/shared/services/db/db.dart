import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class SQLHelper {
  static Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "mj.db");

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 1, onCreate: (Database db, int version) async {
      await createTables(db);
    });
  }

  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE products(
        id TEXT PRIMARY KEY NOT NULL,
        image_path TEXT,
        bar_code TEXT,
        description TEXT,
        order INTEGER,
        category TEXT,
        category2 TEXT,
        category3 TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE lists(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE list_products(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        FOREIGN KEY (list_id) REFERENCES lists (id),
        FOREIGN KEY (product_id) REFERENCES products (id),
        quantity INTEGER NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    // await database.execute("""CREATE TABLE markets(
    //   id INTEGER PRIMARY KEY NOT NULL,
    //   image_path TEXT,
    //   site TEXT,
    //   name TEXT,
    //   latitude REAL,
    //   longitude REAL,
    //   order INTEGER,
    //   cnpj TEXT,
    //   phone_number TEXT,
    //   address TEXT,
    //   createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    // )
    // """);
  }
}
