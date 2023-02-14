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
  const CreateSignatureByCardPage({Key? key}) : super(key: key);

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
          child: Column(
            children: [
              const Text('Adicione um cartão para realizar a assinatura',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: [InputFormater.cpfMask],
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.how_to_reg_outlined),
                    hintText: 'CPF',
                    border: OutlineInputBorder()),
                controller: cpfController,
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
                          hintText: 'Validade',
                          border: OutlineInputBorder()),
                      controller: validityController,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [InputFormater.cvvMask()],
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.private_connectivity_outlined),
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
                              cardStore.createSignature(SignatureRequestModel(
                                  email: authController.user!.email,
                                  userId: authController.user!.id,
                                  card: CardSignatureModel(
                                    holderName: holdeNameController.text,
                                    cardNumber: cardNumberController.text
                                        .replaceAll(' ', ''),
                                    cpf: cpfController.text
                                        .replaceAll('.', '')
                                        .replaceAll('-', ''),
                                    expirationMonth:
                                        validityController.text.split('/')[0],
                                    expirationYear:
                                        validityController.text.split('/')[1],
                                    cvv: cvvController.text,
                                    userId: authController.user!.id,
                                  )));
                            },
                      child: cardStore.signatureState is AppStateLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'ASSINAR',
                              style: TextStyle(fontSize: 18),
                            ));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
