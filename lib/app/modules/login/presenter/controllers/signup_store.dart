import 'package:mobx/mobx.dart';

import 'package:mercado_justo/app/modules/login/domain/usecases/signup_usecase.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStoreBase with _$SignupStore;

abstract class _SignupStoreBase with Store {
  ISignUpUsecase _signUpUsecase;
  _SignupStoreBase(
    this._signUpUsecase,
  );

  @observable
  AppState sigupState = AppStateEmpty();

  Future<void> signUp() async {}
}
