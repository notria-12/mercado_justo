import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';

abstract class ISendLoginCodeByEmail {
  Future<void> call({required String email});
}

class SendLoginCodeByEmailImpl implements ISendLoginCodeByEmail {
  final ILoginRepository _repository;
  SendLoginCodeByEmailImpl(
    this._repository,
  );

  @override
  Future<void> call({required String email}) async {
    try {
      await _repository.sendLoginCodeByEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }
}
