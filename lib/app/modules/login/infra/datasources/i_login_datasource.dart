import 'package:mercado_justo/shared/models/user_model.dart';

abstract class ILoginDatasource {
  Future<void> sendLoginCodeByEmail({required String email});
  Future<void> loginWithEmailCode(
      {required String code, required String email});
  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      required void Function(String, int?) codeSent,
      required Function(Exception e) verificationFailed});
  Future<void> loginWithSmsCode(
      {required String verificationId,
      required String smsCode,
      required phoneNumber});
  Future<void> signUpUsecase({required UserModel user, String? inviteId});
}
