import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mercado_justo/app/modules/login/login_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/input_formaters.dart';

import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, LoginStore> {
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
                'ACESSAR SUA CONTA',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextInput(
                validator: ((value) {
                  if (value!.length != 15) {
                    return "Informe um número válido";
                  }
                }),
                inputType: TextInputType.phone,
                inputFotmatters: [InputFormater.phoneMask],
                label: 'Seu celular com DD',
                hintText: 'DDD + número',
                icon: const Icon(Icons.phone),
                onSave: (input) => store.phoneNumber = input,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.maxFinite,
                child: Observer(builder: (_) {
                  return store.loginState != AppStateLoading
                      ? ElevatedButton(
                          child: const Text(
                            'Enviar código',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            final formState = _formKey.currentState!;
                            if (formState.validate()) {
                              formState.save();
                              store.verifyPhoneNumber().then((value) =>
                                  Modular.to.pushNamed('/login/receivedCode/'));
                            }
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text("OU"),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 50,
              //   width: double.maxFinite,
              //   child: Observer(builder: (_) {
              //     return ElevatedButton.icon(
              //       icon: Icon(MdiIcons.google),
              //       label: Text(
              //         'Entrar com Google',
              //         style: TextStyle(fontSize: 16),
              //       ),
              //       onPressed: () {
              //         store.loginGoogle();
              //       },
              //     );
              //   }),
              // ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Modular.to.pushNamed('/login/codeEmail/');
                  },
                  child: const Text(
                    'Acessar com meu email',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        fontSize: 16,
                        textBaseline: TextBaseline.alphabetic),
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
                    Modular.to.pushNamed('/login/signup/');
                  },
                  child: const Text(
                    'Criar uma conta',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        fontSize: 16,
                        textBaseline: TextBaseline.alphabetic),
                  )),
            ],
          ),
        )),
      ),
    );
  }
}
