import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app//modules/login/presenter/controllers/login_by_email_code_store.dart';
 
void main() {
  late LoginByEmailCodeStore store;

  setUpAll(() {
    store = LoginByEmailCodeStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}