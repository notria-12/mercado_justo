import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app//modules/login/presenter/controllers/signup_store.dart';
 
void main() {
  late SignupStore store;

  setUpAll(() {
    store = SignupStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}