import 'package:mercado_justo/app/modules/login/domain/usecases/login_with_email_code_usecase.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/app/modules/login/domain/usecases/send_login_code_by_email_usecase.dart';

part 'login_by_email_code_store.g.dart';

class LoginByEmailCodeStore = _LoginByEmailCodeStoreBase
    with _$LoginByEmailCodeStore;

abstract class _LoginByEmailCodeStoreBase with Store {
  final ISendLoginCodeByEmail _sendLoginCodeByEmail;
  final ILoginWithEmailCodeUsecase _loginWithEmailCodeUsecase;
  _LoginByEmailCodeStoreBase(
      this._sendLoginCodeByEmail, this._loginWithEmailCodeUsecase);

  @observable
  AppState sendLoginCodeState = AppStateEmpty();

  @observable
  AppState loginState = AppStateEmpty();

  @observable
  String? email;

  @observable
  String? code;

  Future<void> sendLoginCodeByEmail() async {
    try {
      sendLoginCodeState = AppStateLoading();
      await _sendLoginCodeByEmail.call(email: email!);
      sendLoginCodeState = AppStateSuccess();
    } on Failure catch (e) {
      sendLoginCodeState = AppStateError(error: e);
    }
  }

  Future<void> loginWithEmailCode() async {
    try {
      loginState = AppStateLoading();
      await _loginWithEmailCodeUsecase.call(code: code!, email: email!);
      loginState = AppStateSuccess();
    } on Failure catch (e) {
      loginState = AppStateError(error: e);
    }
  }
}
