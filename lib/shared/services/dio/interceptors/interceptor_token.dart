import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';

class TokenInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path != "/login/application") {
      final token = Modular.get<AuthController>().token;
      options.headers.addAll({
        "Authorization": "Bearer $token",
        "X-App-Origem": "APP_MERCADO_JUSTO"
      });
    }

    super.onRequest(options, handler);
  }
}
