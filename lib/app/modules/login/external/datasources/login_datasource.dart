import 'package:dio/dio.dart';

import 'package:mercado_justo/app/modules/login/infra/datasources/i_login_datasource.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDatasourceImpl implements ILoginDatasource {
  final Dio _dio;
  final AuthController _authController;
  LoginDatasourceImpl(this._dio, this._authController);
  @override
  Future<void> sendLoginCodeByEmail({required String email}) async {
    try {
      await _dio.post('auth/codigo-login/', data: {'email': email});
    } on DioError catch (e) {
      throw Failure(title: 'Erro login', message: e.response!.data['mensagem']);
    } catch (e) {
      throw Failure(
          title: 'Erro login',
          message: 'Não foi possível enviar código para seu email');
    }
  }

  @override
  Future<void> loginWithEmailCode(
      {required String code, required String email}) async {
    try {
      var result = await _dio.post("auth/login-email/",
          data: {"token": code, "email": email},
          options: Options(headers: {"X-App-Origem": "SWAGGER_MERCADO_JUSTO"}));
      _authController.updateToken(result.data['dados']['access_token']);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('token', _authController.token);
      _authController.update(AuthState.authenticated);
    } on DioError catch (e) {
      throw Failure(title: 'Erro login', message: e.response!.data['mensagem']);
    } catch (e) {
      throw Failure(
          title: 'Erro login',
          message: 'Erro! Verique se você preencheu o código corretamente');
    }
  }
}
