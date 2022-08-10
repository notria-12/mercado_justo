import 'package:mercado_justo/app/modules/login/domain/usecases/verify_phone_number_usecase.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

part 'login_by_sms_code_store.g.dart';

class LoginBySmsCodeStore = _LoginBySmsCodeStoreBase with _$LoginBySmsCodeStore;

abstract class _LoginBySmsCodeStoreBase with Store {
  IVerifyPhoneNumberUsecase _verifyPhoneNumberUsecase;

  _LoginBySmsCodeStoreBase(this._verifyPhoneNumberUsecase);

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
            throw Failure(
                message: 'Não foi possível enviar o código',
                title: 'Erro Login');
          });
    } on Failure catch (e) {
      sendLoginCodeState = AppStateError(error: e);
    }
  }
}
