import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/login_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  LoginRepository repository;
  _LoginStoreBase(this.repository);

  @observable
  String? phoneNumber;

  @observable
  String? code;

  @observable
  String? cpf;

  @observable
  String? password;

  @observable
  String? verificationId;

  @observable
  AppState loginState = AppStateEmpty();

  Future loginWithCPF() async {
    try {
      loginState = AppStateLoading();
      await repository.signInWithEmail(cpf!, password!);
      loginState = AppStateSuccess();
      Modular.to.pushReplacementNamed("/home_auth/");
    } catch (e) {
      loginState = AppStateError();
    }
  }

  Future loginGoogle() async {
    try {
      repository.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }

  Future verifyPhoneNumber() async {
    try {
      loginState = AppStateLoading();
      verificationId = await repository.verifyPhoneNumber(phoneNumber!);
      loginState = AppStateSuccess();
    } catch (e) {
      loginState = AppStateError();
      rethrow;
    }
  }

  Future verifyCode() async {
    try {
      loginState = AppStateLoading();
      await repository.verifyCode(verificationId!, code!);
      loginState = AppStateSuccess();
    } catch (e) {
      loginState = AppStateError();
      rethrow;
    }
  }
}
