import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/../shared/controllers_store.dart';
 
void main() {
  late ControllersStore store;

  setUpAll(() {
    store = ControllersStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}