import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/login_store.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/login_by_sms_code_store.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/teste_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/input_formaters.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';
import 'package:mobx/mobx.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginBySmsCode = Modular.get<LoginStore>();
  // final _loginTeste = Modular.get<TesteStore>();

  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = autorun((_) {
      if (_loginBySmsCode.sendLoginCodeState is AppStateError) {
        final stateError = _loginBySmsCode.sendLoginCodeState as AppStateError;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(stateError.error.message)));
      }
      if (_loginBySmsCode.sendLoginCodeState is AppStateSuccess) {
        Modular.to.pushNamed('/login/receivedCode/');
      }
    });
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
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
                onSave: (input) => _loginBySmsCode.phoneNumber = input,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.maxFinite,
                child: Observer(builder: (_) {
                  return _loginBySmsCode.sendLoginCodeState is AppStateLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          child: const Text(
                            'Enviar código',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            final formState = _formKey.currentState!;
                            if (formState.validate()) {
                              formState.save();
                              _loginBySmsCode
                                  .verifyPhoneNumber()
                                  .then((value) {});
                            }
                          },
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
