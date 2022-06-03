import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/../shared/controllers/market_name_store.dart';
 
void main() {
  late MarketNameStore store;

  setUpAll(() {
    store = MarketNameStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}