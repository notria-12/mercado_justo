import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:clipboard/clipboard.dart';

class PixPaymentPage extends StatefulWidget {
  const PixPaymentPage({Key? key}) : super(key: key);

  @override
  State<PixPaymentPage> createState() => _PixPaymentPageState();
}

class _PixPaymentPageState extends State<PixPaymentPage> {
  final _signatureStore = Modular.get<SignatureStore>();
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _signatureStore
          .getSignature(userId: Modular.get<AuthController>().user!.id)
          .then((value) {
        if (_signatureStore.signature != null &&
            _signatureStore.signature!.status) {
          Modular.to.pushNamedAndRemoveUntil('/', (p0) => false);
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pagamento via Pix',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<String>(
          future: _signatureStore.buildQRPix(
              user: Modular.get<AuthController>().user!),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: const Center(
                        child: Text(
                            'Infelizmente obtvemos problemas ao gerar a chave pix. Tente novamente mais tarde!')),
                  );
                }
                return Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset('assets/img/pix-logo.png'),
                        height: 200,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Assinatura aguardando pagamento',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Copie o código abaixo e utilize o Pix Copia e Cola no aplicativo que você vai fazer o pagamento',
                        style: TextStyle(
                            color: Colors.black26, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.black26,
                              )),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  snapshot.data!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    FlutterClipboard.copy(snapshot.data!).then(
                                        (value) => ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Copiado para a área de transferência'),
                                            )));
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: Colors.lightBlue,
                                  ))
                            ],
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Quando identificarmos o seu pagamento seu acesso será atualizado...',
                        style: TextStyle(
                            color: Colors.black26, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      LinearProgressIndicator()
                    ],
                  ),
                );
              default:
                return Container();
            }
          }),
    );
  }
}
