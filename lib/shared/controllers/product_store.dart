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
  bool isSearch = false;

  @observable
  AppState productState = AppStateEmpty();

  @observable
  bool canLoadMore = true;

  @observable
  bool onlyButtonLoadMore = false;

  @observable
  int page = 1;

  Future getAllProducts() async {
    try {
      isSearch = false;
      productState = AppStateLoading();
      var productsResult = await repository.getAllProducts(page: page);
      if (productsResult.length < 15) {
        canLoadMore = false;
      } else {
        canLoadMore = true;
      }
      products = [...products, ...productsResult];
      page++;
      productState = AppStateSuccess();
    } catch (e) {
      productState = AppStateError();
      rethrow;
    }
  }

  Future<Product> getProductByBarcode({required String barcode}) async {
    try {
      return repository.getProductByBarcode(barcode: barcode);
    } catch (e) {
      rethrow;
    }
  }

  Future getProductsByDescription(
      {required String description, bool isNewSearch = true}) async {
    try {
      if (isSearch) {
        if (isNewSearch) {
          page = 1;
        } else {
          page++;
        }
      } else {
        page = 1;
      }

      productState = AppStateLoading();
      var productsResult = await repository.getProductsByDescription(
          description: description, page: page);
      if (productsResult.length < 15) {
        canLoadMore = false;
      } else {
        canLoadMore = true;
      }
      if (isNewSearch) {
        products = productsResult;

        isSearch = true;
      } else {
        products = [...products, ...productsResult];
      }

      productState = AppStateSuccess();
    } catch (e) {
      productState = AppStateError();
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
