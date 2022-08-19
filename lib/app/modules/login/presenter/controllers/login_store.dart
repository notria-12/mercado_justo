import 'package:mercado_justo/app/modules/login/domain/usecases/login_with_sms_code_usecase.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/signup_usecase.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/verify_phone_number_usecase.dart';
import 'package:mercado_justo/shared/models/user_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final IVerifyPhoneNumberUsecase _verifyPhoneNumberUsecase;
  final ILoginWithSmsCode _loginWithSmsCode;
  ISignUpUsecase _signUpUsecase;
  _LoginStoreBase(this._verifyPhoneNumberUsecase, this._loginWithSmsCode,
      this._signUpUsecase);

  @observable
  String? phoneNumber;

  @observable
  String? code;

  @observable
  String? verificationId;

  @observable
  AppState signupState = AppStateEmpty();

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

  Future<void> signUp({required UserModel user}) async {
    try {
      signupState = AppStateLoading();
      await _signUpUsecase.call(user: user);
      signupState = AppStateSuccess();
    } on Failure catch (e) {
      signupState = AppStateError(error: e);
    }
  }
}
