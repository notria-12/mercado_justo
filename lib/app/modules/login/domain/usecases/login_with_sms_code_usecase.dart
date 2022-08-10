import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';

abstract class ILoginWithSmsCode {
  Future<void> call(
      {required String verificationId,
      required String smsCode,
      required phoneNumber});
}

class LoginWithSmsCode implements ILoginWithSmsCode {
  final ILoginRepository _repository;
  LoginWithSmsCode(
    this._repository,
  );
  @override
  Future<void> call(
      {required String verificationId,
      required String smsCode,
      required phoneNumber}) async {
    try {
      await _repository.loginWithSmsCode(
          verificationId: verificationId,
          smsCode: smsCode,
          phoneNumber: phoneNumber);
    } catch (e) {
      rethrow;
    }
  }
}
