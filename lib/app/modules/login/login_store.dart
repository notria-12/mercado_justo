import 'package:mercado_justo/app/modules/login/login_repository.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  LoginRepository repository;
  _LoginStoreBase(this.repository);

  @observable
  String? phoneNumber;

  Future verifyPhoneNumber(String phoneNumber, String code) async {
    try {
      await repository.verifyPhoneNumber(phoneNumber, code);
    } catch (e) {
      rethrow;
    }
  }
}
