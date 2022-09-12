import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/profile/widgets/button_profile_option.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seu perfil'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 240, 241, 241),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_outline,
                    size: 60,
                    color: Colors.black38,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                _authController.user!.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _authController.user!.email,
                style: TextStyle(
                    color: Colors.black26, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'CONTA FREE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                ),
                padding: EdgeInsets.all(4),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Cadastrado desde 14/04/2021 23:04',
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
              InkWell(
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
              RichText(
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: ' 5 dias ',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: 'de uso gratuito!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))
                      ],
                      text: 'Restam',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)))
            ],
          ),
        ),
      ),
    );
  }
}
