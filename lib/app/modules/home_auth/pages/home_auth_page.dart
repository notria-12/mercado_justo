import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mercado_justo/app/modules/compare/pages/compare_page.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_store.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/home_auth_content.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_drawer.dart';
import 'package:mercado_justo/app/modules/lists/pages/product_list_page.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/controllers/connectivity_store.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/no_connectivity_widget.dart';
import 'package:mobx/mobx.dart';

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
  List<String> titles = ['Início', 'Minhas Listas', 'PoupaMais'];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ReactionDisposer _disposer;
  final storePosition = Modular.get<PositionStore>();
  final connectivityStore = Modular.get<ConnectivityStore>();
  @override
  void initState() {
    super.initState();
    _disposer = reaction((_) => storePosition.position, (_) {
      print("POSITION::${storePosition.position}");
      Modular.get<MarketStore>().setMarkets();
    });
    Modular.get<SignatureStore>()
        .getSignature(userId: Modular.get<AuthController>().user!.id);
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SafeArea(
          child: connectivityStore.hasConnection!
              ? Scaffold(
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
                    onTap: (index) {
                      if (store.currentIndex == 0 && index == 0) {
                        if (Modular.get<ProductStore>().productState
                            is! AppStateLoading) {
                          Modular.get<ProductStore>().onlyButtonLoadMore =
                              false;
                          Modular.get<ProductStore>()
                              .getAllProducts(initialProducts: true);
                        }
                      }
                      store.onTabTapped(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined), label: 'Início'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.my_library_books_outlined),
                          label: 'Minhas listas'),
                      BottomNavigationBarItem(
                          icon: Icon(MdiIcons.setCenter), label: 'PoupaMais'),
                    ],
                    backgroundColor: const Color.fromARGB(255, 240, 241, 241),
                    //fixedColor: Colors.grey,
                    // selectedItemColor: Colors.lightGreen,
                    unselectedItemColor: Colors.black,
                  ),
                )
              : Scaffold(
                  body: NoConnectionWidget(),
                ),
        );
      },
    );
  }
}
