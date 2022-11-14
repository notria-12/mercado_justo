import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
// import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class CreditCardPaymentPage extends StatefulWidget {
  const CreditCardPaymentPage({Key? key}) : super(key: key);

  @override
  State<CreditCardPaymentPage> createState() => _CreditCardPaymentPageState();
}

class _CreditCardPaymentPageState extends State<CreditCardPaymentPage> {
  final _signatureStore = Modular.get<SignatureStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                      'Infelizmente obtvemos problemas ao iniciar o pagamento. Tente novamente mais tarde'),
                );
              } else {
                return Container(
                  child: ElevatedButton(
                    child: const Text('Iniciar pagamento'),
                    onPressed: () async {
                      // PaymentResult result =
                      //     await MercadoPagoMobileCheckout.startCheckout(
                      //   'APP_USR-d8eeccfe-80ae-4a0f-bc53-a11122657dad',
                      //   snapshot.data!,
                      // );
                      // print(result.toString());
                    },
                  ),
                );
              }
            default:
              return Container();
          }
        },
        // future: _signatureStore.getPreference(
        //     email: Modular.get<AuthController>().user!.email),
      ),
    );
  }
}
