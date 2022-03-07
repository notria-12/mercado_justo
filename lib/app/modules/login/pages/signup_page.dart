import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final String title;
  const SignUpPage({Key? key, this.title = 'SignUpPage'}) : super(key: key);
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
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
        padding: EdgeInsets.all(16),
        // color: Colors.amber,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/logo.png'),
                        fit: BoxFit.cover)),
              ),
              // Image.asset('assets/img/logo.png'),
              SizedBox(
                height: 8,
              ),
              Text(
                'CADASTRO',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seu Nome',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    // padding: EdgeInsets.all(4),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Seu nome completo',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person)),
                    ),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Celular',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    // padding: EdgeInsets.all(4),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'DDD + número',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.phone)),
                    ),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Seu E-mail',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    // padding: EdgeInsets.all(4),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Seu e-mail',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email)),
                    ),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Já tenho conta',
                    style: TextStyle(
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
