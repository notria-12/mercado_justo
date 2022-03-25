import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/home_auth_content.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/product_list_page.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/widgets/custom_table_widget.dart';

class HomeAuthPage extends StatefulWidget {
  final String title;
  const HomeAuthPage({Key? key, this.title = 'HomeAuthPage'}) : super(key: key);
  @override
  HomeAuthPageState createState() => HomeAuthPageState();
}

class HomeAuthPageState extends State<HomeAuthPage> {
  List<Widget> pages = [
    HomeAuthContent(),
    ProductListPage(),
    Container(),
    Container(),
  ];
  List<String> titles = ['Início', 'Minhas Listas', 'Carrinho', ''];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[_currentIndex]),
        backgroundColor: Colors.green,
        leading: Container(),
        actions: [
          Container(
            // padding: EdgeInsets.all(8),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {
                Modular.to.pushNamed('/profile/');
              },
              child: Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Início'),
          BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined),
              label: 'Minhas listas'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.cartVariant), label: 'Carrinho'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Mais')
        ],
        backgroundColor: Color.fromARGB(255, 240, 241, 241),
        //fixedColor: Colors.grey,
        // selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.black,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
