import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/login_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
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
      loginState = AppStateError(error: Failure(title: '', message: ''));
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
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+55 " + phoneNumber!,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              print('The provided phone number is not valid.');
            }
          },
          codeSent: (String verificationId, int? resendToken) async {
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            this.verificationId = verificationId;
          },
          timeout: const Duration(seconds: 90));
      print(verificationId);
      loginState = AppStateSuccess();
    } catch (e) {
      loginState = AppStateError(error: Failure(title: '', message: ''));
      rethrow;
    }
  }

  Future verifyCode() async {
    try {
      loginState = AppStateLoading();
      await repository.verifyCode(verificationId!, code!);
      await repository.signInWithEmail('609.163.593-01', '12345678');
      loginState = AppStateSuccess();
      Modular.to.pushReplacementNamed(
        '/home_auth/',
      );
    } catch (e) {
      loginState = AppStateError(error: Failure(title: '', message: ''));
      rethrow;
    }
  }
}
