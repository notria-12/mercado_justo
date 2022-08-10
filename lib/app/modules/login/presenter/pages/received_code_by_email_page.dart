import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:mercado_justo/app/modules/login/presenter/controllers/login_by_email_code_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';
import 'package:mobx/mobx.dart';

class ReceivedCodeByEmailPage extends StatefulWidget {
  const ReceivedCodeByEmailPage({Key? key}) : super(key: key);

  @override
  State<ReceivedCodeByEmailPage> createState() => _ReceivedCodePageState();
}

class _ReceivedCodePageState extends State<ReceivedCodeByEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginWithEmailCodeStore = Modular.get<LoginByEmailCodeStore>();
  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = autorun((_) {
      if (_loginWithEmailCodeStore.loginState is AppStateError) {
        final stateError = _loginWithEmailCodeStore.loginState as AppStateError;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(stateError.error.message)));
      }
      if (_loginWithEmailCodeStore.loginState is AppStateSuccess) {
        Modular.to.pushReplacementNamed("/home_auth/");
      }
    });
  }

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
                'CÓDIGO',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextInput(
                  validator: (input) {
                    if (input!.length < 6) {
                      return "Informe um código válido";
                    }
                  },
                  onSave: (input) => _loginWithEmailCodeStore.code = input,
                  label: 'Código recebido',
                  hintText: 'Informe o código',
                  icon: const Icon(Icons.lock)),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return Container(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      child:
                          _loginWithEmailCodeStore.loginState is AppStateLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 16),
                                ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.lightBlue),
                      onPressed: _loginWithEmailCodeStore.loginState
                              is AppStateLoading
                          ? null
                          : () {
                              var formState = _formKey.currentState!;
                              if (formState.validate()) {
                                formState.save();
                                _loginWithEmailCodeStore.loginWithEmailCode();
                              }
                            },
                    ));
              }),
              const SizedBox(
                height: 30,
              ),
              // TextButton(
              //     style: TextButton.styleFrom(
              //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //       minimumSize: Size.zero,
              //       padding: EdgeInsets.zero,
              //     ),
              //     onPressed: () {},
              //     child: const Text(
              //       'Não estou com acesso ao meu celular',
              //       style: TextStyle(
              //           decoration: TextDecoration.underline,
              //           color: Colors.grey,
              //           fontSize: 16,
              //           textBaseline: TextBaseline.alphabetic),
              //     )),
            ],
          ),
        )),
      ),
    );
  }
}
