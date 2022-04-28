import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_store.dart';
 
void main() {
  late HomeAuthStore store;

  setUpAll(() {
    store = HomeAuthStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}