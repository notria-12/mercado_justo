import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app//modules/lists/filter_store.dart';
 
void main() {
  late FilterStore store;

  setUpAll(() {
    store = FilterStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}