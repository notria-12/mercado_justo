import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mercado_justo/app/modules/login/infra/datasources/i_login_datasource.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/models/user_model.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDatasourceImpl implements ILoginDatasource {
  final Dio _dio;
  final AuthController _authController;

  LoginDatasourceImpl(
    this._dio,
    this._authController,
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

  @override
  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      required void Function(String p1, int? p2) codeSent,
      required Function(Exception e) verificationFailed}) async {
    try {
      await _dio.post('auth/verifica-numero/', data: {'telefone': phoneNumber});
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+55 " + phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: (String verificationId) {},
          timeout: const Duration(seconds: 120));
    } on DioError catch (e) {
      throw Failure(title: 'Erro login', message: e.response!.data['mensagem']);
    } on Failure catch (e) {
      rethrow;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      throw Failure(
          title: 'Erro login',
          message: 'Não conseguimos enviar o código para esse número!');
    }
  }

  @override
  Future<void> loginWithSmsCode(
      {required String verificationId,
      required String smsCode,
      required phoneNumber}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String token = await userCredential.user!.getIdToken();
      var result = await _dio.post(
        "auth/login-phone/",
        data: {"firebase_token": token, "phone": phoneNumber},
      );
      _authController.updateToken(result.data['dados']['access_token']);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('token', _authController.token);
      _authController.update(AuthState.authenticated);
    } catch (e) {
      throw Failure(
          title: 'Erro login',
          message: 'Erro! Verique se você preencheu o código corretamente!');
    }
  }

  @override
  Future<void> signUpUsecase({required UserModel user}) async {
    try {
      await _dio.post('usuarios/app/', data: user.toJson());
    } on DioError catch (e) {
      throw Failure(title: 'Erro login', message: e.response!.data['mensagem']);
    } catch (e) {
      throw Failure(
          title: 'Erro login',
          message: 'Não foi possível realizar o cadastro!');
    }
  }
}
