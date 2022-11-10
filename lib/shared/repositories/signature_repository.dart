import 'package:dio/dio.dart';
import 'package:mercado_justo/shared/models/signature_model.dart';
import 'package:mercado_justo/shared/models/user_model.dart';

class SignatureRepository {
  final Dio _dio;

  SignatureRepository(this._dio);

  Future<String> buildQRPix({required UserModel user}) async {
    try {
      var result = await _dio.post('/assinaturas/pix', data: user.toMap());
      return result.data['dados']['qr_code'] as String;
    } catch (e) {
      rethrow;
    }
  }

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
