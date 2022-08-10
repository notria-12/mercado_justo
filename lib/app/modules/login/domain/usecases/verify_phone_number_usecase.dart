import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';

abstract class IVerifyPhoneNumberUsecase {
  Future<void> call(
      {required String phoneNumber,
      required void Function(String verificationId, int? resendCode) codeSent,
      required Function(Exception e) verificationFailed});
}

class VerifyPhoneNumberUsecase implements IVerifyPhoneNumberUsecase {
  ILoginRepository _repository;
  VerifyPhoneNumberUsecase(
    this._repository,
  );
  @override
  Future<void> call(
      {required String phoneNumber,
      required void Function(String verificationId, int? resendCode) codeSent,
      required Function(Exception e) verificationFailed}) async {
    try {
      await _repository.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          codeSent: codeSent,
          verificationFailed: verificationFailed);
    } catch (e) {
      rethrow;
    }
  }
}
