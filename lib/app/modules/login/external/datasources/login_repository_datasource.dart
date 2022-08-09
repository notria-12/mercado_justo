import 'package:dio/dio.dart';

import 'package:mercado_justo/app/modules/login/infra/datasources/i_login_datasource.dart';
import 'package:mercado_justo/shared/utils/error.dart';

class LoginDatasourceImpl implements ILoginDatasource {
  Dio _dio;
  LoginDatasourceImpl(
    this._dio,
  );
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
}
