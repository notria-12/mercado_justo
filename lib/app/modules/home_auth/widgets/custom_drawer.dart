import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/drawer_item.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Modular.to.pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.lightBlue,
                )),
            Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/logo.png'))))
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        DrawerItem(
            child: const Text(
              'Meu Perfil',
              style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            onTap: () {
              Modular.to.pushNamed('/profile/');
            }),
        if (Modular.get<SignatureStore>().signature == null ||
            !Modular.get<SignatureStore>().signature!.status)
          DrawerItem(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              color: Colors.green,
              child: const Text('Seja Premium',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
            onTap: () {
              Modular.to.pushNamed('/signature/');
            },
          ),
        DrawerItem(
            child: const Text(
          'Redes Sociais',
          style: TextStyle(
              fontSize: 15,
              // fontWeight: FontWeight.w400,
              color: Colors.black87),
        )),
        DrawerItem(
            child: const Text(
          'Avaliar Mercado Justo',
          style: TextStyle(
              fontSize: 15,
              // fontWeight: FontWeight.w400,
              color: Colors.black87),
        )),
        DrawerItem(
            onTap: () {
              Modular.to.pushNamed('/home_auth/faq/');
            },
            child: const Text(
              'Perguntas Frequentes',
              style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.w400,
                  color: Colors.black87),
            )),
        DrawerItem(
            child: const Text(
          'Compartilhar o App com Amigos',
          style: TextStyle(
              fontSize: 15,
              // fontWeight: FontWeight.w400,
              color: Colors.black87),
        )),
        DrawerItem(
            onTap: () {
              Modular.to.pushNamed('/home_auth/terms/');
            },
            child: const Text(
              'Termos e Condições',
              style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.w400,
                  color: Colors.black87),
            )),
        DrawerItem(
            onTap: () {
              Modular.to.pushNamed('/home_auth/config/');
            },
            child: const Text(
              'Configurações',
              style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.w400,
                  color: Colors.black87),
            )),
        DrawerItem(
          child: const Text(
            'Sair',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          onTap: () {
            Modular.to.pop();
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Tem Certeza que deseja sair?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text("Você será deslogado"),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Modular.get<AuthController>().logoutUser();
                                },
                                child: Container(
                                  width: 170,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      'Sair',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Modular.to.pop();
                                },
                                child: Container(
                                  width: 170,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ]),
                  );
                });
          },
        ),
      ]),
    ));
  }
}
