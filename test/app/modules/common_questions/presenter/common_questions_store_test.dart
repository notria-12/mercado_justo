import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/modules/common_questions/presenter/common_questions_store.dart';
 
void main() {
  late CommonQuestionsStore store;

  setUpAll(() {
    store = CommonQuestionsStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}