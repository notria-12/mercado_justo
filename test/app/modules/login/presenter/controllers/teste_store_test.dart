import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app//modules/login/presenter/controllers/teste_store.dart';
 
void main() {
  late TesteStore store;

  setUpAll(() {
    store = TesteStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}