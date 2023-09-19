import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/drawer_item.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:mercado_justo/shared/utils/dynamic_links.dart';
import 'package:mercado_justo/shared/widgets/dialogs.dart';
import 'package:share_plus/share_plus.dart';

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
            onTap: () {
              Dialogs().socialNetworkDialog(context);
            },
            child: const Text(
              'Redes Sociais',
              style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.w400,
                  color: Colors.black87),
            )),
        DrawerItem(
            onTap: () async {
              final InAppReview inAppReview = InAppReview.instance;

              if (await inAppReview.isAvailable()) {
                inAppReview.requestReview();
              }
            },
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
            onTap: () async {
              DynamicLinkProvider()
                  .createLink(Modular.get<AuthController>().user!.id)
                  .then((value) => Share.share(
                      "Baixe agora o app Mercado Justo, o melhor comparador de preços de supermercados e ganhe 30 dias de uso gratuito!\n\n$value\n\nAlém disso você ainda ganha +1 dia gratuito pra cada vez que você compartilhar com outro amigo(a)"));
            },
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
