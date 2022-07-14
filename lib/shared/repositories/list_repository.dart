import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/models/product_list_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/services/db/db.dart';
import 'package:sqflite/sqflite.dart';

class ListRepository {
  Future<int> createList(ListModel list) async {
    try {
      //TODO pensar forma de injetar dependência de SQLHelper
      Database database = await SQLHelper.init();

      int id = await database.insert('lists', list.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      return id;
    } catch (e) {
      rethrow;
    }
  }

  Future updateListName({required int listId, required String newName}) async {
    try {
      //TODO pensar forma de injetar dependência de SQLHelper
      Database database = await SQLHelper.init();

      await database.update('lists', {'name': newName},
          where: '"id" = $listId');
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

  Future subtractList(
      {required int mainListId,
      required int secondaryLisId,
      required String mainListName}) async {
    try {
      Database database = await SQLHelper.init();
      List<ProductListModel> mainProductList =
          await getProductsByList(mainListId);
      List<ProductListModel> secondaryProductList =
          await getProductsByList(secondaryLisId);

      List<ProductListModel> newProductList = mainProductList
          .where((element) => !secondaryProductList.contains(element))
          .toList();

      int id =
          await createList(ListModel(name: mainListName + '(Itens Faltando)'));

      for (var listItem in newProductList) {
        await database.insert(
            'list_products',
            {
              'product_id': listItem.productId,
              'list_id': id,
              'quantity': listItem.quantity
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future duplicateList({required int listId, required String listName}) async {
    try {
      Database database = await SQLHelper.init();
      List<ProductListModel> mainProductList = await getProductsByList(listId);
      int id = await createList(ListModel(name: listName + '(Copia)'));

      for (var listItem in mainProductList) {
        await database.insert(
            'list_products',
            {
              'product_id': listItem.productId,
              'list_id': id,
              'quantity': listItem.quantity
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
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
