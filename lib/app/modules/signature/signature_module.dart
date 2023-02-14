import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/signature/controllers/card_invoice_controller.dart';
import 'package:mercado_justo/app/modules/signature/pages/choose_signature_page.dart';
import 'package:mercado_justo/app/modules/signature/pages/create_signature_by_card_page.dart';
import 'package:mercado_justo/app/modules/signature/pages/credit_card_payment.dart';
import 'package:mercado_justo/app/modules/signature/pages/pix_payment_page.dart';
import 'package:mercado_justo/app/modules/signature/repositories/card_repository.dart';

class SignatureModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CardRepository(i())),
    Bind.lazySingleton((i) => CardInvoiceStore(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const ChooseSignaturePage(),
    ),
    ChildRoute('/pix/', child: ((context, args) => const PixPaymentPage())),
    ChildRoute('/card/',
        child: ((context, args) => const CreditCardPaymentPage())),
    ChildRoute('/create-signature/',
        child: ((context, args) => const CreateSignatureByCardPage()))
  ];
}
