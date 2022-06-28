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

  static Future destroyDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "mj.db");
    await deleteDatabase(path);
  }

  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE products(
        id INTEGER PRIMARY KEY NOT NULL,
        hash_id TEXT,
        image_path TEXT,
        bar_code TEXT,
        description TEXT,
        product_order INTEGER,
        category TEXT,
        category_2 TEXT,
        category_3 TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE lists(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE names_markets(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        list_id INTEGER NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (list_id) REFERENCES lists (id)
      )
      """);
    await database.execute("""CREATE TABLE prices(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        price REAL,
        list_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (list_id) REFERENCES lists (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
      """);

    await database.execute("""CREATE TABLE list_products(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        list_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
        FOREIGN KEY (list_id) REFERENCES lists (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
      """);
  }
}
