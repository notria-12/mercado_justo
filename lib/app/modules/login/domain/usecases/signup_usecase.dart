import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';
import 'package:mercado_justo/shared/models/user_model.dart';

abstract class ISignUpUsecase {
  Future<void> call({required UserModel user, String? inviteId});
}

class SignUpUseCase implements ISignUpUsecase {
  ILoginRepository _repository;
  SignUpUseCase(
    this._repository,
  );
  @override
  Future<void> call({required UserModel user, String? inviteId}) async {
    try {
      await _repository.signUpUsecase(user: user, inviteId: inviteId);
    } catch (e) {
      rethrow;
    }
  }
}
