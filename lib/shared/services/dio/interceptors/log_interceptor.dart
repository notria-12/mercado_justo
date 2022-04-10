import 'package:dio/dio.dart';

class AppLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("REQ => ${options.path} ${options.data != null ? "" : '\n BODY:${options.data}'}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("RES => STATUS: ${response.statusCode}\n [1;32mDATA:${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        "RES-ERROR => STATUS: ${err.response != null ? err.response!.statusCode : "DESCONHECIDO"}\n DATA:${err.response != null ? err.response!.data : "ERROR NO FLUTTER"}}");
    super.onError(err, handler);
  }
}
