import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';

class ReceivedCodePage extends StatefulWidget {
  const ReceivedCodePage({Key? key}) : super(key: key);

  @override
  State<ReceivedCodePage> createState() => _ReceivedCodePageState();
}

class _ReceivedCodePageState extends State<ReceivedCodePage> {
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
              'CÓDIGO',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextInput(
                label: 'Código recebido',
                hintText: 'Informe o código',
                icon: const Icon(Icons.lock)),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                onPressed: () {
                  Modular.to.pushNamedAndRemoveUntil(
                      '/home_auth/', ModalRoute.withName('/'));
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: const Text(
                  'Não estou com acesso ao meu celular',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.grey,
                      fontSize: 16,
                      textBaseline: TextBaseline.alphabetic),
                )),
          ],
        )),
      ),
    );
  }
}
