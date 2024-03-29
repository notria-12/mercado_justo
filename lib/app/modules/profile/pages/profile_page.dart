import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mercado_justo/app/modules/profile/widgets/button_profile_option.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:mercado_justo/shared/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final _authController = Modular.get<AuthController>();
  final _signatureController = Modular.get<SignatureStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu perfil'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 240, 241, 241),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person_outline,
                    size: 60,
                    color: Colors.black38,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return Text(
                  _authController.user!.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Observer(builder: (_) {
                return Text(
                  _authController.user!.email,
                  style: TextStyle(
                      color: Colors.black26, fontWeight: FontWeight.w500),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  _signatureController.signature != null &&
                          _signatureController.signature!.status
                      ? 'CONTA PREMIUM'
                      : 'CONTA FREE',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                ),
                padding: EdgeInsets.all(4),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Cadastrado desde ${DateFormat('dd/MM/yyyy hh:mm').format(_authController.user!.registerDate!)}',
                style: TextStyle(
                    color: Colors.black26, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonProfileOptions(
                label: 'Editar informações pessoais',
                onTap: () {
                  Modular.to.pushNamed('/profile/edit');
                },
              ),
              SizedBox(
                height: 15,
              ),
              ButtonProfileOptions(
                  label: 'Relatar um problema',
                  onTap: () {
                    Utils.launchEmail();
                  }),
              SizedBox(
                height: 15,
              ),
              ButtonProfileOptions(
                label: 'Alterar localização',
                onTap: () {
                  Modular.to.pushNamed('/profile/maps');
                },
              ),
              SizedBox(
                height: 15,
              ),
              (_signatureController.signature != null &&
                          _signatureController.signature!.status ||
                      _signatureController.signature != null &&
                          _signatureController.signature!.pendingPayment)
                  ? _signatureController.signature!.paymentType == 'card'
                      ? InkWell(
                          onTap: () {
                            Modular.to.pushNamed('/signature/card');
                          },
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                                child: Text('Ver assinatura',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16))),
                          ),
                        )
                      : _signatureController.signature!.pendingPayment
                          ? InkWell(
                              onTap: () {
                                Modular.to.pushNamed('/signature/pix/');
                              },
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                    child: Text('Ver assinatura',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16))),
                              ),
                            )
                          : Text('Sua assinatura está ativa:',
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w500))
                  : InkWell(
                      onTap: () {
                        Modular.to.pushNamed('/signature/');
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                            child: Text('Seja Premium',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16))),
                      ),
                    ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: _signatureController.signature != null &&
                    _signatureController.signature!.status &&
                    _signatureController.signature!.paymentType != 'card',
                child: FutureBuilder<double>(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return RichText(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: ' ${snapshot.data!.ceil()} dias ',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: 'de uso!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600))
                                  ],
                                  text: 'Restam',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)));
                        } else {
                          return Container();
                        }

                      default:
                        return Container();
                    }
                  },
                  future: _signatureController.getRemainingDays(
                      userId: _authController.user!.id),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
