import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/repositories/product_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mobx/mobx.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStoreBase with _$ProductStore;

abstract class _ProductStoreBase with Store {
  ProductRepository repository;
  _ProductStoreBase({
    required this.repository,
  });

  @observable
  List<Product> products = [];

  @observable
  List<Product> searchProductsResult = [];

  @observable
  AppState searchProductsState = AppStateEmpty();

  @observable
  AppState productState = AppStateEmpty();

  @observable
  int page = 1;

  Future getAllProducts() async {
    try {
      productState = AppStateLoading();
      var productsResult = await repository.getAllProducts(page: page);
      products = [...products, ...productsResult];
      page++;
      productState = AppStateSuccess();
    } catch (e) {
      productState = AppStateError();
      rethrow;
    }
  }

  Future getProductsByDescription({required String description}) async {
    try {
      searchProductsState = AppStateLoading();
      searchProductsResult =
          await repository.getProductsByDescription(description: description);
      searchProductsState = AppStateSuccess();
    } catch (e) {
      searchProductsState = AppStateError();
      rethrow;
    }
  }

  Future<String> getProductImage({required String barCode}) async {
    try {
      productState = AppStateLoading();
      String imagePath = await repository.getProductImage(barCode);
      productState = AppStateSuccess();
      return imagePath;
    } catch (e) {
      productState = AppStateError();
      rethrow;
    }
  }
}
