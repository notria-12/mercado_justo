import 'package:dio/dio.dart';

import 'package:mercado_justo/app/modules/login/internal/datasources/i_login_datasource.dart';

class LoginDatasourceImpl implements ILoginDatasource {
  Dio _dio;
  LoginDatasourceImpl(
    this._dio,
  );
  @override
  Future<void> sendLoginCodeByEmail({required String email}) async {
    try {
      await _dio.post('auth/codigo-login/', data: {'email': email});
    } catch (e) {
      //TODO: Tratar execessão
      rethrow;
    }
  }
}
