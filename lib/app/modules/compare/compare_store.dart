import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'compare_store.g.dart';

class CompareStore = _CompareStoreBase with _$CompareStore;

abstract class _CompareStoreBase with Store {
  Future addToComparePage(int listId) async {
    final sharedPrefences = await SharedPreferences.getInstance();

    sharedPrefences.setInt('current_list', listId);
  }

  Future<int?> getCurrentList() async {
    final sharedPrefences = await SharedPreferences.getInstance();
    if (sharedPrefences.containsKey('current_list')) {
      return sharedPrefences.getInt('current_list')!;
    }
  }
}
