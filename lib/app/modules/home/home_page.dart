import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home/home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bem Vindo'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.asset('assets/img/logo.png'),
                    SizedBox(
                      height: 8,
                    ),
                    RichText(
                        text: const TextSpan(
                            text: 'Economia de verdade',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: ' é aqui!',
                              style: TextStyle(fontWeight: FontWeight.normal))
                        ])),
                    const Text(
                        'Entre, e compare os preços da sua lista de compras!'),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: 260,
                      height: 45,
                      child: ElevatedButton(
                        child: Text('Entrar / Cadastrar'),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                flex: 4,
              ),
              Expanded(
                flex: 6,
                child: Container(color: Colors.amber),
              )
            ],
          ),
        ));
  }
}
