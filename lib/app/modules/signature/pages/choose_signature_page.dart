import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';

class ChooseSignaturePage extends StatefulWidget {
  const ChooseSignaturePage({Key? key}) : super(key: key);

  @override
  State<ChooseSignaturePage> createState() => _ChooseSignaturePageState();
}

class _ChooseSignaturePageState extends State<ChooseSignaturePage> {
  bool pixValue = false;
  bool cardValue = true;
  final _signatureStore = Modular.get<SignatureStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assinar Mercado Justo',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
          color: Colors.white,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Seja Premium!",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(
                      children: [
                    TextSpan(
                        text: 'Mercado Justo ',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    TextSpan(
                        text: 'com toda a segurança e tecnologia por apenas ',
                        style: TextStyle(color: Colors.black38, fontSize: 16)),
                    TextSpan(
                        text: ' R\$ 2,99/mês',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                      text: 'Assine o ',
                      style: TextStyle(color: Colors.black38, fontSize: 16))),
              SizedBox(
                height: 25,
              ),
              Card(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 241, 241),
                          border: Border.all(
                              color: Color.fromARGB(255, 214, 211, 211)),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4),
                              topLeft: Radius.circular(4))),
                      height: 60,
                      child: Observer(
                        builder: (_) {
                          return SwitchListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: _signatureStore.paymentByCreditCard,
                              onChanged: _signatureStore.setPaymentByCreditCard,
                              title: Text('Cartão de crédito',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)));
                        },
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 241, 241),
                            border: Border.all(
                                color: Color.fromARGB(255, 214, 211, 211)),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4))),
                        height: 60,
                        child: Observer(builder: (_) {
                          return SwitchListTile(
                            title: Text(
                              'Pix',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _signatureStore.paymentByPix,
                            onChanged: _signatureStore.setPaymentByPix,
                          );
                        })),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  if (_signatureStore.paymentByPix) {
                    Modular.to.pushNamed('/signature/pix/');
                  } else {
                    Modular.to.pushNamed('/signature/create-signature/',
                        arguments: false);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(4)),
                  width: double.maxFinite,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Avançar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
