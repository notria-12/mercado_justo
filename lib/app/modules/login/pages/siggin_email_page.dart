import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/login_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/input_formaters.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';

class SignInEmailPage extends StatefulWidget {
  const SignInEmailPage({Key? key}) : super(key: key);

  @override
  State<SignInEmailPage> createState() => _SignInEmailPageState();
}

class _SignInEmailPageState extends ModularState<SignInEmailPage, LoginStore> {
  final _formKey = GlobalKey<FormState>();
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
            child: Form(
          key: _formKey,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe seu CPF";
                  }
                },
                label: 'Seu CPF',
                hintText: 'digite o cpf',
                icon: const Icon(Icons.person),
                onSave: (input) => store.cpf = input,
                inputFotmatters: [InputFormater.cpfMask],
              ),
              CustomTextInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe sua senha";
                  }
                },
                label: 'Senha',
                hintText: 'Insira sua senha',
                icon: const Icon(Icons.lock),
                onSave: (input) => store.password = input,
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return Container(
                  height: 50,
                  width: double.maxFinite,
                  child: store.loginState is AppStateLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            var formState = _formKey.currentState!;
                            if (formState.validate()) {
                              formState.save();
                              store.loginWithCPF();
                            }
                          },
                        ),
                );
              }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
