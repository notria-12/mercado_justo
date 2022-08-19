import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/login_store.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/signup_store.dart';
import 'package:mercado_justo/shared/models/user_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/input_formaters.dart';
import 'package:mercado_justo/shared/utils/input_validators.dart';
import 'package:mercado_justo/shared/widgets/custom_text_input_widget.dart';
import 'package:mobx/mobx.dart';

class SignUpPage extends StatefulWidget {
  final String title;
  const SignUpPage({Key? key, this.title = 'SignUpPage'}) : super(key: key);
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final signUpStore = Modular.get<LoginStore>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = autorun((_) {
      if (signUpStore.signupState is AppStateError) {
        final stateError = signUpStore.signupState as AppStateError;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(stateError.error.message)));
      }
      if (signUpStore.signupState is AppStateSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cadastro realizado com sucesso!')));
        Modular.to.pop();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _disposer();
    super.dispose();
  }

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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextInput(
                        controller: _nameController,
                        inputType: TextInputType.name,
                        label: 'Seu Nome',
                        hintText: 'Seu nome completo',
                        validator: InputValidators.validateNotEmpyField,
                        icon: Icon(Icons.account_circle_rounded),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextInput(
                          controller: _cpfController,
                          inputType: TextInputType.number,
                          validator: InputValidators.cpfValidator,
                          inputFotmatters: [InputFormater.cpfMask],
                          label: 'CPF',
                          hintText: 'Digite seu cpf',
                          icon: const Icon(Icons.person)),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextInput(
                          controller: _phoneController,
                          inputFotmatters: [InputFormater.phoneMask],
                          inputType: TextInputType.phone,
                          label: 'Celular',
                          hintText: 'DDD + número',
                          validator: InputValidators.validatePhone,
                          icon: const Icon(Icons.phone)),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextInput(
                          controller: _emailController,
                          validator: InputValidators.validateEmail,
                          inputType: TextInputType.emailAddress,
                          label: 'Seu E-mail',
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
                            child: signUpStore.signupState is AppStateLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text(
                                    'Cadastrar',
                                    style: TextStyle(fontSize: 16),
                                  ),
                            onPressed: signUpStore.signupState
                                    is AppStateLoading
                                ? null
                                : () {
                                    var formState = _formKey.currentState!;
                                    if (formState.validate()) {
                                      signUpStore.signUp(
                                          user: UserModel(
                                              name: _nameController.text,
                                              cpf: _cpfController.text,
                                              email: _emailController.text,
                                              phone: _phoneController.text));
                                    }
                                  },
                          ),
                        );
                      }),
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
