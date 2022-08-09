import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';
import 'package:mercado_justo/app/modules/login/infra/datasources/i_login_datasource.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final ILoginDatasource _datasource;
  LoginRepositoryImpl(
    this._datasource,
  );

  @override
  Future<void> sendLoginCodeByEmail({required String email}) async {
    try {
      await _datasource.sendLoginCodeByEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> loginWithEmailCode(
      {required String code, required String email}) async {
    try {
      await _datasource.loginWithEmailCode(code: code, email: email);
    } catch (e) {
      rethrow;
    }
  }
}
