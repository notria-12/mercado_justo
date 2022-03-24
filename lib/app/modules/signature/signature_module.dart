import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/signature/pages/choose_signature_page.dart';

class SignatureModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => ChooseSignaturePage(),
    )
  ];
}
