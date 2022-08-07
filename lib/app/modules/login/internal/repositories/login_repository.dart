import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';
import 'package:mercado_justo/app/modules/login/internal/datasources/i_login_datasource.dart';

class LoginRepositoryImpl implements ILoginRepository {
  ILoginDatasource _datasource;
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
}
