import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';

import 'interceptors/interceptor_refresh_token.dart';
import 'interceptors/interceptor_token.dart';
import 'interceptors/log_interceptor.dart';

class CustomDioBrowser extends DioForBrowser {
  CustomDioBrowser() {
    const baseUrl = String.fromEnvironment("BASE_URL",
        defaultValue:
            "https://mercado-justo-api.herokuapp.com/mercado-justo/api/v1/");
    options.baseUrl = baseUrl;
    options.headers.addAll({"X-App-Origem": "ADMIN_MERCADO_JUSTO"});
    interceptors.addAll([
      AppLogInterceptor(),
      TokenInterceptor(),
      RefreshTokenInterceptor(),
    ]);
  }
}

Dio getDioInstance() => CustomDioBrowser();
