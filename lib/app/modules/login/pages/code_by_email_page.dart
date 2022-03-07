import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';

class CodeEmailPage extends StatefulWidget {
  const CodeEmailPage({Key? key}) : super(key: key);

  @override
  State<CodeEmailPage> createState() => _CodeEmailPageState();
}

class _CodeEmailPageState extends State<CodeEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo!'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/logo.png'),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Entrar com e-mail',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextInput(
                label: 'Seu email cadastrado',
                hintText: 'Seu e-mail',
                icon: const Icon(Icons.email)),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                child: const Text(
                  'Enviar código',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Modular.to.pushNamed('/login/receivedCode/');
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        )),
      ),
    );
  }
}
