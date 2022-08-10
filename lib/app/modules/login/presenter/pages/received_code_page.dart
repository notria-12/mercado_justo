import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/login_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';
import 'package:mobx/mobx.dart';

class ReceivedCodePage extends StatefulWidget {
  const ReceivedCodePage({Key? key}) : super(key: key);

  @override
  State<ReceivedCodePage> createState() => _ReceivedCodePageState();
}

class _ReceivedCodePageState
    extends ModularState<ReceivedCodePage, LoginStore> {
  final _formKey = GlobalKey<FormState>();

  late ReactionDisposer _disposer;
  @override
  void initState() {
    super.initState();
    _disposer = autorun((_) {
      if (store.loginState is AppStateError) {
        final stateError = store.loginState as AppStateError;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(stateError.error.message)));
      }
      if (store.loginState is AppStateSuccess) {
        Modular.to.pushReplacementNamed('/home_auth/');
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
                  onSave: (input) => store.code = input,
                  label: 'Código recebido',
                  hintText: 'Informe o código',
                  icon: const Icon(Icons.lock)),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.maxFinite,
                child: Observer(builder: (_) {
                  return ElevatedButton(
                    child: store.loginState is AppStateLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 16),
                          ),
                    style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                    onPressed: store.loginState is AppStateLoading
                        ? null
                        : () {
                            var formState = _formKey.currentState!;
                            if (formState.validate()) {
                              formState.save();
                              print(store.code);
                              store.loginWithSmsCode();
                            }
                          },
                  );
                }),
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
          ),
        )),
      ),
    );
  }
}
