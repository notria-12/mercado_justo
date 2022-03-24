import 'package:flutter/material.dart';
import 'package:mercado_justo/app/modules/profile/widgets/custom_input_profile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Meus Dados'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 40,
              ),
              CustomInputProfile(
                label: 'Seu nome',
              ),
              SizedBox(
                height: 20,
              ),
              CustomInputProfile(label: 'Celular(DDD+número)'),
              SizedBox(
                height: 20,
              ),
              CustomInputProfile(label: 'Seu email'),
              SizedBox(
                height: 20,
              ),
              CustomInputProfile(
                label: 'Nascimento',
                // hintText: 'dd/mm/aaaa',
              ),
              SizedBox(
                height: 20,
              ),
              CustomInputProfile(label: 'Estado'),
              SizedBox(
                height: 20,
              ),
              CustomInputProfile(label: 'Cidade'),
            ]),
          )),
    );
  }
}
