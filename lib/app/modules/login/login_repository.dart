import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';

class LoginRepository {
  Dio dio;
  AuthController authController;
  LoginRepository(this.dio, {required this.authController});
  FirebaseAuth auth = FirebaseAuth.instance;

  Future signInWithEmail(String cpf, String password) async {
    try {
      var result = await dio.post("auth/login/",
          data: {"cpf": cpf, "senha": password},
          options: Options(headers: {"X-App-Origem": "SWAGGER_MERCADO_JUSTO"}));
      authController.updateToken(result.data['dados']['access_token']);
    } catch (e) {
      rethrow;
    }
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    await dio.post("/auth/login-google/", data: {
      "google_id": googleAuth!.accessToken,
      "id_token": googleAuth.idToken,
      "nome": "Airton Sousa",
      "email": "airton.ifma@gmail.com"
    });

    // Create a new credential
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );

    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String?> verifyPhoneNumber(String phoneNumber) async {
    String? verificationId;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+55 " + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    return verificationId;
  }

  Future verifyCode(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await auth.signInWithCredential(credential);
  }
}
