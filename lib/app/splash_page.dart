import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final authController = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              // Modular.to.pushReplacementNamed('/login/');
              return Container();
            default:
              return Container();
          }
        },
        future: Future.wait(
            [authController.init(), Future.delayed(Duration(seconds: 3))]),
      ),
    );
  }
}
