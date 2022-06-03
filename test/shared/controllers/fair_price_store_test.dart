import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/../shared/controllers/fair_price_store.dart';
 
void main() {
  late FairPriceStore store;

  setUpAll(() {
    store = FairPriceStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}