import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mercado_justo/app/modules/compare/pages/compare_page.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_store.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/home_auth_content.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_drawer.dart';
import 'package:mercado_justo/app/modules/lists/pages/product_list_page.dart';

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
    const ComparePage(),
  ];
  List<String> titles = ['Início', 'Minhas Listas', 'Comparativo'];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            endDrawer: const CustomDrawer(),
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
