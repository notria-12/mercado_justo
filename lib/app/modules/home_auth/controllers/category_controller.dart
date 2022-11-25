import 'package:mercado_justo/app/modules/home_auth/models/category_model.dart';
import 'package:mercado_justo/app/modules/home_auth/repositories/category_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

part 'category_controller.g.dart';

class CategoryStore = _CategoryStoreBase with _$CategoryStore;

abstract class _CategoryStoreBase with Store {
  CategoryRepository _repository;
  _CategoryStoreBase(this._repository);

  @observable
  CategoryModel? selectedCategory;

  @observable
  bool canUpdate = false;

  @observable
  AppState secondaryCategoriesStatus = AppStateEmpty();

  ObservableList<CategoryModel> secodaryCategories = ObservableList.of([]);

  Future<List<CategoryModel>> getMainCategories() {
    return _repository.getMainCategories();
  }

  void getSecondaryCategories(String categoryId) async {
    try {
      secondaryCategoriesStatus = AppStateLoading();
      secodaryCategories = ObservableList.of(
          await _repository.getSecondaryCategories(categoryId));
      canUpdate = false;
      secondaryCategoriesStatus = AppStateSuccess();
    } on Failure catch (e) {
      secondaryCategoriesStatus = AppStateError(error: e);
    }
  }
}
