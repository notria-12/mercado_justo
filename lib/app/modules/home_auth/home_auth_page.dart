import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_store.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/home_auth_content.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/product_list_page.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/drawer_item.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';

class HomeAuthPage extends StatefulWidget {
  final String title;
  const HomeAuthPage({Key? key, this.title = 'HomeAuthPage'}) : super(key: key);
  @override
  HomeAuthPageState createState() => HomeAuthPageState();
}

class HomeAuthPageState extends ModularState<HomeAuthPage, HomeAuthStore> {
  List<Widget> pages = [
    const HomeAuthContent(),
    const ProductListPage(),
    Container(),
  ];
  List<String> titles = ['Início', 'Minhas Listas', 'Carrinho'];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            endDrawer: Drawer(
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
                  'Início',
                  style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.w400,
                      color: Colors.black87),
                )),
                DrawerItem(
                    child: const Text(
                  'Minhas Listas',
                  style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.w400,
                      color: Colors.black87),
                )),
                DrawerItem(
                    child: const Text(
                  'Meu Perfil',
                  style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.w400,
                      color: Colors.black87),
                )),
                DrawerItem(
                    child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  color: Colors.green,
                  child: const Text('Seja Premium',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                )),
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
                    child: const Text(
                  'Termos e Condições',
                  style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.w400,
                      color: Colors.black87),
                )),
                DrawerItem(
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
                    Modular.get<AuthController>().logoutUser();
                  },
                ),
              ]),
            )),
            appBar: AppBar(
              centerTitle: true,
              title: Text(titles[store.currentIndex]),
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
              actions: [
                Container(
                  // padding: EdgeInsets.all(8),
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      Modular.to.pushNamed('/profile/');
                    },
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            body: IndexedStack(
              children: pages,
              index: store.currentIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: store.currentIndex,
              onTap: store.onTabTapped,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Início'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.my_library_books_outlined),
                    label: 'Minhas listas'),
                BottomNavigationBarItem(
                    icon: Icon(MdiIcons.setCenter), label: 'Comparar'),
              ],
              backgroundColor: const Color.fromARGB(255, 240, 241, 241),
              //fixedColor: Colors.grey,
              // selectedItemColor: Colors.lightGreen,
              unselectedItemColor: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
