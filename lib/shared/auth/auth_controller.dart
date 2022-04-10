import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

enum AuthState { authenticated, unauthenticated }

abstract class _AuthControllerBase extends Disposable with Store {
  late ReactionDisposer disposer;
  _AuthControllerBase() {
    // init();
    // disposer = autorun((_) {
    //   if (state == AuthState.authenticated) {
    //     Modular.to.pushReplacementNamed('/home/');
    //   } else if (state == AuthState.unauthenticated) {
    //     Modular.to.pushReplacementNamed('/login/');
    //   }
    // });
  }

  String token = "";
  String refreshToken = "";

  void updateToken(String token) => this.token = token;

  // @observable
  // UserModel? user;

  // setUser(UserModel? value) => user = value;

  // void loginUser(UserModel user) {
  //   setUser(user);
  //   update(AuthState.authenticated);
  // }

  void logoutUser() async {
    // setUser(null);
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.remove('user');
    update(AuthState.unauthenticated);
  }

  @observable
  AuthState state = AuthState.unauthenticated;

  @computed
  bool get isUserAutenticated => (state == AuthState.authenticated);

  @action
  update(AuthState value) => state = value;

  // Future<void> init() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   print(preferences.getString('user'));

  //   if (preferences.containsKey("user")) {
  //     setUser(UserModel.fromJson(preferences.getString("user")!));
  //     updateToken(user!.token!);
  //     update(AuthState.authenticated);
  //     // Modular.to.pushReplacementNamed('/home/');
  //   } else {
  //     update(AuthState.unauthenticated);
  //     // Modular.to.pushReplacementNamed('/login/');
  //   }
  // }

  @override
  void dispose() {
    disposer();
  }
}
