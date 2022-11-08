import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/signature_model.dart';

class SignatureRepository {
  final Dio _dio;

  SignatureRepository(this._dio);

  Future<SignatureModel> getSignature({required String userId}) async {
    try {
      var result = await _dio.get('/assinaturas/$userId');
      return SignatureModel.fromMap(result.data['dados']);
    } catch (e) {
      rethrow;
    }
  }

  Future<double> getRemainingDays({required String userId}) async {
    try {
      var result = await _dio.get('/assinaturas/dias/$userId');
      return result.data['dados']['dias_restantes'] as double;
    } catch (e) {
      rethrow;
    }
  }
}
