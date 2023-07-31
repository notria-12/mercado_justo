import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/signature/controllers/card_invoice_controller.dart';
import 'package:mercado_justo/app/modules/signature/models/signature_request_model.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/input_formaters.dart';
import 'package:mobx/mobx.dart';

class CreateSignatureByCardPage extends StatefulWidget {
  bool isUpdate;
  CreateSignatureByCardPage({Key? key, this.isUpdate = false})
      : super(key: key);

  @override
  State<CreateSignatureByCardPage> createState() =>
      _CreateSignatureByCardPageState();
}

class _CreateSignatureByCardPageState extends State<CreateSignatureByCardPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController holdeNameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController validityController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final cardStore = Modular.get<CardInvoiceStore>();
  final authController = Modular.get<AuthController>();

  @override
  void initState() {
    super.initState();
    autorun((event) {
      if (cardStore.signatureState is AppStateError) {
        var e = cardStore.signatureState as AppStateError;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.error.message),
          backgroundColor: Colors.redAccent,
        ));
      }
      if (cardStore.signatureState is AppStateSuccess) {
        Modular.to.pushNamedAndRemoveUntil('/', (p0) => false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Assinatura realizada com sucesso'),
          backgroundColor: Colors.green,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Adicionar Cartão',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                    widget.isUpdate
                        ? 'Adicione um novo cartão para atualizar a assinatura'
                        : 'Adicione um cartão para realizar a assinatura',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  inputFormatters: [InputFormater.cardMask()],
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.credit_card),
                      hintText: 'Número do cartão',
                      border: OutlineInputBorder()),
                  controller: cardNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    if (!isCreditCardValid(value)) {
                      return 'Número inválido!';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Nome do titular',
                      border: OutlineInputBorder()),
                  controller: holdeNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(signed: true),
                        inputFormatters: [InputFormater.cardValidity()],
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_month_outlined),
                            hintText: 'MM/AAAA',
                            border: OutlineInputBorder()),
                        controller: validityController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          if (value.length != 7) {
                            return 'Informe mm/aaaa';
                          }
                          int month = int.parse(value.substring(0, 2));

                          if (month <= 0 || month > 12) {
                            return 'Mês inválido';
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                        }),
                        keyboardType:
                            TextInputType.numberWithOptions(signed: true),
                        inputFormatters: [InputFormater.cvvMask()],
                        decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.private_connectivity_outlined),
                            hintText: 'CVV',
                            border: OutlineInputBorder()),
                        controller: cvvController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Observer(builder: (_) {
                    return ElevatedButton(
                        onPressed: cardStore.signatureState is AppStateLoading
                            ? null
                            : () {
                                if (widget.isUpdate) {
                                  cardStore.updateSignature(CardSignatureModel(
                                      holderName: holdeNameController.text,
                                      cardNumber: cardNumberController.text
                                          .replaceAll(' ', ''),
                                      expirationMonth:
                                          validityController.text.split('/')[0],
                                      expirationYear:
                                          validityController.text.split('/')[1],
                                      cvv: cvvController.text,
                                      userId: authController.user!.id));
                                } else {
                                  final formState = _formKey.currentState;
                                  if (formState!.validate()) {
                                    cardStore
                                        .createSignature(SignatureRequestModel(
                                            email: authController.user!.email,
                                            userId: authController.user!.id,
                                            card: CardSignatureModel(
                                              holderName:
                                                  holdeNameController.text,
                                              cardNumber: cardNumberController
                                                  .text
                                                  .replaceAll(' ', ''),
                                              expirationMonth:
                                                  validityController.text
                                                      .split('/')[0],
                                              expirationYear: validityController
                                                  .text
                                                  .split('/')[1],
                                              cvv: cvvController.text,
                                              userId: authController.user!.id,
                                            )));
                                  }
                                }
                              },
                        child: cardStore.signatureState is AppStateLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                widget.isUpdate ? 'ATUALIZAR' : 'ASSINAR',
                                style: TextStyle(fontSize: 18),
                              ));
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isCreditCardValid(String cardNumber) {
    // Remove quaisquer espaços em branco ou caracteres não numéricos do número do cartão
    cardNumber = cardNumber.replaceAll(RegExp(r'[^0-9]'), '');

    // Verifica se o número do cartão possui pelo menos 13 dígitos e no máximo 19 dígitos
    if (cardNumber.length < 13 || cardNumber.length > 19) {
      return false;
    }

    // Aplica o algoritmo de Luhn para verificar a validade do número do cartão
    int sum = 0;
    bool alternate = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }
}
