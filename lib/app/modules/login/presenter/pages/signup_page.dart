import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';

class SignUpPage extends StatefulWidget {
  final String title;
  const SignUpPage({Key? key, this.title = 'SignUpPage'}) : super(key: key);
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Cadastro',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/logo.png'),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'CADASTRO',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextInput(
                      label: 'Seu Nome',
                      hintText: 'Seu nome completo',
                      icon: const Icon(Icons.person)),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextInput(
                      label: 'Celular',
                      hintText: 'DDD + número',
                      icon: const Icon(Icons.phone)),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextInput(
                      label: 'Seu E-mail',
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
                        'Cadastrar',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Modular.to.pushReplacementNamed('/login/');
                  },
                  child: const Text(
                    'Já tenho conta',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        fontSize: 16,
                        textBaseline: TextBaseline.alphabetic),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
