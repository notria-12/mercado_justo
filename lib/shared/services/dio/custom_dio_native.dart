import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import 'interceptors/interceptor_refresh_token.dart';
import 'interceptors/interceptor_token.dart';
import 'interceptors/log_interceptor.dart';

class CustomDioNative extends DioForNative {
  CustomDioNative() {
    const baseUrl = String.fromEnvironment("BASE_URL");
    options.baseUrl = baseUrl;
    interceptors.addAll([
      AppLogInterceptor(),
      TokenInterceptor(),
      RefreshTokenInterceptor(),
    ]);
  }
}

Dio getDioInstance() => CustomDioNative();
