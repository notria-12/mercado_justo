import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/signature/controllers/card_invoice_controller.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/extensions.dart';
// import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class CreditCardPaymentPage extends StatefulWidget {
  const CreditCardPaymentPage({Key? key}) : super(key: key);

  @override
  State<CreditCardPaymentPage> createState() => _CreditCardPaymentPageState();
}

class _CreditCardPaymentPageState extends State<CreditCardPaymentPage> {
  final _signatureStore = Modular.get<SignatureStore>();
  final _cardInvoiceStore = Modular.get<CardInvoiceStore>();
  @override
  void initState() {
    super.initState();
    if (_signatureStore.signature!.pendingPayment) {
      _cardInvoiceStore.getInvoice(id: _signatureStore.signature!.paymentId);
    }
    _cardInvoiceStore.getCard(id: Modular.get<AuthController>().user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Assinatura Cartão',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Observer(
            builder: (_) {
              if (_cardInvoiceStore.invoiceState is AppStateLoading) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (_cardInvoiceStore.invoiceState is AppStateError) {
                return Center(
                  child: Text((_cardInvoiceStore.invoiceState as AppStateError)
                      .error
                      .message),
                );
              }

              if (_cardInvoiceStore.cardState is AppStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Status da assinatura: ',
                            children: [
                              TextSpan(
                                  text:
                                      _signatureStore.signature!.pendingPayment
                                          ? 'Pendente'
                                          : 'Ativa',
                                  style: TextStyle(
                                    color: _signatureStore
                                            .signature!.pendingPayment
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ))
                            ],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ))),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Sua próxima cobrança será em ',
                            children: [
                              TextSpan(
                                  text:
                                      _signatureStore.signature!.pendingPayment
                                          ? (_cardInvoiceStore
                                              .invoice!.nextRetryDate!.toDate)
                                          : (_signatureStore.signature!
                                              .expirationDate.toDate),
                                  style: const TextStyle(
                                    // color: Colors.lightBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ))
                            ],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ))),
                    const SizedBox(height: 15),
                    const Text('Cartão',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    Card(
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.credit_card,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(_cardInvoiceStore.card!.firstSixDigits!
                                    .substring(0, 4) +
                                " **** **** " +
                                _cardInvoiceStore.card!.lastFourDigits!),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.change_circle_sharp,
                                color: Colors.lightBlue,
                              ),
                              label: Text('Trocar'))
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      child: TextButton(
                        child: const Text(
                          'Cancelar Assinatura',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Descrição: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(
                      height: 5,
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          _signatureStore.signature!.pendingPayment
                              ? 'Seu último pagamento não foi realizado. Certifique-se de ter limite disponível na próxima tentativa de cobrança!'
                              : 'Tudo certo com sua assinatura. Certifique-se de ter limite disponível na próxima data de cobrança!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
