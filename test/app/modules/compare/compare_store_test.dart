import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/modules/compare/compare_store.dart';
 
void main() {
  late CompareStore store;

  setUpAll(() {
    store = CompareStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}