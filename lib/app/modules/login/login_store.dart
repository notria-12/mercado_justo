import 'package:mercado_justo/app/modules/login/domain/usecases/login_with_sms_code_usecase.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/verify_phone_number_usecase.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final IVerifyPhoneNumberUsecase _verifyPhoneNumberUsecase;
  final ILoginWithSmsCode _loginWithSmsCode;
  _LoginStoreBase(this._verifyPhoneNumberUsecase, this._loginWithSmsCode);

  @observable
  String? phoneNumber;

  @observable
  String? code;

  @observable
  String? verificationId;

  @observable
  AppState loginState = AppStateEmpty();

  @observable
  AppState sendLoginCodeState = AppStateEmpty();

  Future verifyPhoneNumber() async {
    try {
      sendLoginCodeState = AppStateLoading();
      await _verifyPhoneNumberUsecase.call(
          phoneNumber: phoneNumber!,
          codeSent: (String verificationId, int? resendCode) {
            this.verificationId = verificationId;
            sendLoginCodeState = AppStateSuccess();
          },
          verificationFailed: (e) {
            sendLoginCodeState = AppStateError(
                error: Failure(
                    message: 'Não foi possível enviar o código',
                    title: 'Erro Login'));
          });
    } on Failure catch (e) {
      sendLoginCodeState = AppStateError(error: e);
    }
  }

  Future<void> loginWithSmsCode() async {
    try {
      loginState = AppStateLoading();
      await _loginWithSmsCode.call(
          verificationId: verificationId!,
          smsCode: code!,
          phoneNumber: phoneNumber);
      loginState = AppStateSuccess();
    } on Failure catch (e) {
      loginState = AppStateError(error: e);
    }
  }
  // LoginRepository repository;
  // _LoginStoreBase(this.repository);

  // @observable
  // String? phoneNumber;

  // @observable
  // String? code;

  // @observable
  // String? cpf;

  // @observable
  // String? password;

  // @observable
  // String? verificationId;

  // @observable
  // AppState loginState = AppStateEmpty();

  // Future loginWithCPF() async {
  //   try {
  //     loginState = AppStateLoading();
  //     await repository.signInWithEmail(cpf!, password!);
  //     loginState = AppStateSuccess();
  //     Modular.to.pushReplacementNamed("/home_auth/");
  //   } catch (e) {
  //     loginState = AppStateError(error: Failure(title: '', message: ''));
  //   }
  // }

  // Future loginGoogle() async {
  //   try {
  //     repository.signInWithGoogle();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future verifyPhoneNumber() async {
  //   try {
  //     loginState = AppStateLoading();
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: "+55 " + phoneNumber!,
  //         verificationCompleted: (PhoneAuthCredential credential) {},
  //         verificationFailed: (FirebaseAuthException e) {
  //           if (e.code == 'invalid-phone-number') {
  //             print('The provided phone number is not valid.');
  //           }
  //         },
  //         codeSent: (String verificationId, int? resendToken) async {
  //           this.verificationId = verificationId;
  //         },
  //         codeAutoRetrievalTimeout: (String verificationId) {
  //           this.verificationId = verificationId;
  //         },
  //         timeout: const Duration(seconds: 90));
  //     print(verificationId);
  //     loginState = AppStateSuccess();
  //   } catch (e) {
  //     loginState = AppStateError(error: Failure(title: '', message: ''));
  //     rethrow;
  //   }
  // }

  // Future verifyCode() async {
  //   try {
  //     loginState = AppStateLoading();
  //     await repository.verifyCode(verificationId!, code!);
  //     await repository.signInWithEmail('609.163.593-01', '12345678');
  //     loginState = AppStateSuccess();
  //     Modular.to.pushReplacementNamed(
  //       '/home_auth/',
  //     );
  //   } catch (e) {
  //     loginState = AppStateError(error: Failure(title: '', message: ''));
  //     rethrow;
  //   }
  // }
}
