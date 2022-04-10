import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';

import '../custom_dio.dart';

class RefreshTokenInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null && err.requestOptions.path != "/login/email") {
      if (err.response!.statusCode == 401) {
        final authenticationStore = Modular.get<AuthController>();
        try {
          final currentDio = Modular.get<Dio>();
          currentDio.lock();
          final authenticationStore = Modular.get<AuthController>();
          final refreshToken = authenticationStore.refreshToken;
          final client = getDioInstance();
          final responseToken =
              await client.post("/login/reauthentication", data: {
            "refreshToken": refreshToken,
          });
          final token = responseToken.data['data']['token'];
          authenticationStore.updateToken(token);
          currentDio.unlock();

          final response = await currentDio.request(
            err.requestOptions.path,
            queryParameters: err.requestOptions.queryParameters,
            data: err.requestOptions.data,
            options: Options(headers: err.requestOptions.headers),
          );

          handler.resolve(response);
        } catch (e) {
          authenticationStore.update(AuthState.unauthenticated);
        }
      } else {
        return super.onError(err, handler);
      }
    } else {
      return super.onError(err, handler);
    }
  }
}
