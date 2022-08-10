import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/login_by_email_code_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/input_formaters.dart';
import 'package:mercado_justo/shared/utils/input_validators.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';
import 'package:mobx/mobx.dart';

class CodeEmailPage extends StatefulWidget {
  const CodeEmailPage({Key? key}) : super(key: key);

  @override
  State<CodeEmailPage> createState() => _CodeEmailPageState();
}

class _CodeEmailPageState extends State<CodeEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginByEmailCodeStore = Modular.get<LoginByEmailCodeStore>();
  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = autorun((_) {
      if (_loginByEmailCodeStore.sendLoginCodeState is AppStateError) {
        final stateError =
            _loginByEmailCodeStore.sendLoginCodeState as AppStateError;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(stateError.error.message)));
      }
      if (_loginByEmailCodeStore.sendLoginCodeState is AppStateSuccess) {
        Modular.to.pushNamed('/login/receivedEmailCode/');
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
                'Entrar com e-mail',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextInput(
                  validator: InputValidators.validateEmail,
                  onSave: (input) => _loginByEmailCodeStore.email = input,
                  inputType: TextInputType.emailAddress,
                  label: 'Seu email cadastrado',
                  hintText: 'Seu e-mail',
                  icon: const Icon(Icons.email)),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return Container(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                    child: _loginByEmailCodeStore.sendLoginCodeState
                            is AppStateLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Enviar código',
                            style: TextStyle(fontSize: 16),
                          ),
                    onPressed: _loginByEmailCodeStore.sendLoginCodeState
                            is AppStateLoading
                        ? null
                        : () {
                            var formState = _formKey.currentState!;
                            if (formState.validate()) {
                              formState.save();
                              _loginByEmailCodeStore.sendLoginCodeByEmail();
                            }
                            // Modular.to.pushNamed('/login/receivedCode/');
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
