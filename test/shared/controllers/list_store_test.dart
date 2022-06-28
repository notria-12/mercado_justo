import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/../shared/controllers/list_store.dart';
 
void main() {
  late ListStore store;

  setUpAll(() {
    store = ListStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}