import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
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
              'Rodrigo Luiz',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'rodrigoacad@gmail.com',
              style:
                  TextStyle(color: Colors.black26, fontWeight: FontWeight.w500),
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
              style:
                  TextStyle(color: Colors.black26, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonProfileOptions(
              label: 'Editar informações pessoais',
              onTap: () {},
            ),
            SizedBox(
              height: 15,
            ),
            ButtonProfileOptions(
              label: 'Relatar um problema',
              onTap: () {},
            ),
            SizedBox(
              height: 15,
            ),
            ButtonProfileOptions(
              label: 'Alterar localização',
              onTap: () {},
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(4)),
              child: Center(
                  child: Text('Seja Premium',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16))),
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
    );
  }
}

class ButtonProfileOptions extends StatelessWidget {
  String label;
  VoidCallback onTap;
  ButtonProfileOptions({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black38)),
        height: 50,
        width: 300,
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
