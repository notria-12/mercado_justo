import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';

abstract class ILoginWithEmailCodeUsecase {
  Future<void> call({required String code, required String email});
}

class LoginWithEmailCodeUsecase implements ILoginWithEmailCodeUsecase {
  ILoginRepository _repository;
  LoginWithEmailCodeUsecase(
    this._repository,
  );

  @override
  Future<void> call({required String code, required String email}) async {
    try {
      await _repository.loginWithEmailCode(code: code, email: email);
    } catch (e) {
      rethrow;
    }
  }
}
