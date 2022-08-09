import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/app/modules/login/domain/usecases/send_login_code_by_email_usecase.dart';

part 'login_by_email_code_store.g.dart';

class LoginByEmailCodeStore = _LoginByEmailCodeStoreBase
    with _$LoginByEmailCodeStore;

abstract class _LoginByEmailCodeStoreBase with Store {
  final ISendLoginCodeByEmail _sendLoginCodeByEmail;
  _LoginByEmailCodeStoreBase(
    this._sendLoginCodeByEmail,
  );

  @observable
  AppState sendLoginCodeState = AppStateEmpty();

  Future<void> sendLoginCodeByEmail({required String email}) async {
    try {
      sendLoginCodeState = AppStateLoading();
      await _sendLoginCodeByEmail.call(email: email);
      sendLoginCodeState = AppStateSuccess();
    } on Failure catch (e) {
      sendLoginCodeState = AppStateError(error: e);
    }
  }
}
