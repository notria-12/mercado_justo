import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app//modules/login/presenter/controllers/login_by_sms_code_store.dart';
 
void main() {
  late LoginBySmsCodeStore store;

  setUpAll(() {
    store = LoginBySmsCodeStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}