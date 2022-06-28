import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/../shared/controllers/product_to_list_store.dart';
 
void main() {
  late ProductToListStore store;

  setUpAll(() {
    store = ProductToListStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}