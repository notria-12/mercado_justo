import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/signature/controllers/card_invoice_controller.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/extensions.dart';
import 'package:mobx/mobx.dart';
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
      _cardInvoiceStore.getInvoice(id: _signatureStore.signature!.signatureId!);
    }
    _cardInvoiceStore.getCard(id: Modular.get<AuthController>().user!.id);

    autorun((fn) {
      if (_cardInvoiceStore.cancelState is AppStateError) {
        var e = _cardInvoiceStore.cancelState as AppStateError;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.error.message),
          backgroundColor: Colors.redAccent,
        ));
      }
      if (_cardInvoiceStore.cancelState is AppStateSuccess) {
        Modular.to.pushNamedAndRemoveUntil('/', (p0) => false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Assinatura via cartão cancelada'),
          backgroundColor: Colors.green,
        ));
      }
    });
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

              if (_cardInvoiceStore.cancelState is AppStateError) {
                return const Center(
                  child: Text('Erro ao buscar dados da assinatura!'),
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
                                              .invoice!
                                              .recurrentPayment!
                                              .nextRecurrency!)
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_cardInvoiceStore
                                      .card!.payment!.creditCard!.cardNumber!
                                      .substring(0, 4) +
                                  " **** **** " +
                                  _cardInvoiceStore
                                      .card!.payment!.creditCard!.cardNumber!
                                      .substring(
                                          _cardInvoiceStore
                                                  .card!
                                                  .payment!
                                                  .creditCard!
                                                  .cardNumber!
                                                  .length -
                                              4,
                                          _cardInvoiceStore.card!.payment!
                                              .creditCard!.cardNumber!.length)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // TextButton.icon(
                          //     onPressed: () {
                          //       Modular.to.pushReplacementNamed(
                          //           '/signature/create-signature/',
                          //           arguments: true);
                          //     },
                          //     icon: const Icon(
                          //       Icons.change_circle_sharp,
                          //       color: Colors.lightBlue,
                          //     ),
                          //     label: Text('Trocar'))
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      child: _cardInvoiceStore.cancelState is AppStateLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : TextButton(
                              child: const Text(
                                'Cancelar Assinatura',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Tem certeza que deseja cancelar a assinatura?",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              const Text(
                                                  "Você ainda usufruirá dos dias restantes."),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      _cardInvoiceStore
                                                          .cancelSignature(
                                                              _signatureStore
                                                                  .signature!
                                                                  .signatureId!);
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: const BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child: const Center(
                                                        child: Text(
                                                          'Sim',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Modular.to.pop();
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child: const Center(
                                                        child: Text(
                                                          'Não',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ]),
                                      );
                                    });
                              },
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
