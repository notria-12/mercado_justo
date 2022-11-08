import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:mercado_justo/shared/models/user_model.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

enum AuthState { authenticated, unauthenticated }

abstract class _AuthControllerBase extends Disposable with Store {
  late ReactionDisposer disposer;
  SignatureStore signatureStore;
  _AuthControllerBase({required this.signatureStore}) {
    init();
    disposer = autorun((_) {
      if (state == AuthState.authenticated) {
        Modular.to.pushReplacementNamed('/home_auth/');
      } else if (state == AuthState.unauthenticated) {
        Modular.to.pushReplacementNamed('/home/');
      }
    });
  }

  String token = "";
  String refreshToken = "";

  void updateToken(String token) => this.token = token;

  @observable
  UserModel? user;

  setUser(UserModel? value) => user = value;

  // void loginUser(UserModel user) {
  //   setUser(user);
  //   update(AuthState.authenticated);
  // }

  void logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    preferences.remove('user');
    update(AuthState.unauthenticated);
  }

  @observable
  AuthState state = AuthState.unauthenticated;

  @computed
  bool get isUserAutenticated => (state == AuthState.authenticated);

  @action
  update(AuthState value) => state = value;

  Future<void> init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey("token") && preferences.containsKey('user')) {
      updateToken(preferences.getString("token")!);
      setUser(UserModel.fromJson(preferences.getString('user')!));
      signatureStore.getSignature(userId: user!.id);
      update(AuthState.authenticated);
    } else {
      update(AuthState.unauthenticated);
    }
  }

  @override
  void dispose() {
    disposer();
  }
}
