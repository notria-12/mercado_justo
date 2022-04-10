import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';

import 'interceptors/interceptor_refresh_token.dart';
import 'interceptors/interceptor_token.dart';
import 'interceptors/log_interceptor.dart';

class CustomDioBrowser extends DioForBrowser {
  CustomDioBrowser() {
    const baseUrl = String.fromEnvironment("BASE_URL",
        defaultValue: "https://api2.dev.apagaofogo.eco.br:8001");
    options.baseUrl = baseUrl;
    interceptors.addAll([
      AppLogInterceptor(),
      TokenInterceptor(),
      RefreshTokenInterceptor(),
    ]);
  }
}

Dio getDioInstance() => CustomDioBrowser();
