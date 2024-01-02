import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mercado_justo/app/modules/home/home_store.dart';
import 'package:mercado_justo/app/modules/home/widgets/custom_dialog_selection_markets.dart';
import 'package:mercado_justo/shared/controllers/connectivity_store.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/button_share.dart';
import 'package:mercado_justo/shared/widgets/custom_table_widget.dart';
import 'package:mercado_justo/shared/widgets/dialogs.dart';
import 'package:mercado_justo/shared/widgets/no_connectivity_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../shared/controllers/position_store.dart';
import '../controllers/initial_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final marketStore = Modular.get<MarketStore>();
  final initialStore = Modular.get<InitialStore>();
  late ReactionDisposer _disposer;
  final storePosition = Modular.get<PositionStore>();
  final _dialogs = Dialogs();
  @override
  void initState() {
    super.initState();

    _disposer = reaction((_) => storePosition.position, (_) {
      if (storePosition.position != null) {
        initialStore.getPublicMarkets();
        initialStore.getPublicsProducts();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (storePosition.position == null) {
        _dialogs.requestLocalizationDialog(context);
      }
    });
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bem vindo!'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      child: Image.asset('assets/img/logo.png'),
                      height: 110,
                      width: 110,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                        text: const TextSpan(
                            text: 'Economia de verdade',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text: ' é aqui!',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ))
                        ])),
                    const Text(
                      'Entre e compare os preços da sua lista de compras!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Observer(
                      builder: (_) {
                        return Container(
                          width: 290.w,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue),
                            child: Text(
                              'Entrar / Cadastrar',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            onPressed:
                                !Modular.get<ConnectivityStore>().hasConnection!
                                    ? null
                                    : () {
                                        Modular.to.pushNamed('/login/');
                                      },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Observer(
                    builder: (_) {
                      if (!Modular.get<ConnectivityStore>().hasConnection!) {
                        return NoConnectionWidget();
                      }
                      if (storePosition.position == null &&
                          (storePosition.positionState is! AppStateLoading)) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              child: Image.asset('assets/img/location.png'),
                              height: 150,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Infelizmente não conseguiremos listar mercados e produtos sem sua localização.',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                                onPressed: () {
                                  _dialogs.requestLocalizationDialog(context);
                                },
                                child: const Text(
                                    'Permitir acesso a minha localização'))
                          ],
                        );
                      }
                      if (storePosition.positionState is AppStateLoading) {
                        return Center(
                          child: Column(
                            children: const [
                              Text('Buscando localização'),
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                      if (initialStore.marketState is AppStateLoading) {
                        return Center(
                          child: Column(
                            children: const [
                              Text('Pesquisado mercados disponíveis...'),
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                      if (initialStore.marketState is AppStateError) {
                        return const Center(
                          child: Text(
                              'Erro ao pesquisar mercados. Tente novamente mais tarde'),
                        );
                      } else {
                        if (initialStore.markets.isEmpty) {
                          return Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              SizedBox(
                                child: Image.asset('assets/img/location.png'),
                                height: 150,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Não encontramos nenhum mercado na sua região',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ));
                        }
                        if (initialStore.productState is AppStateLoading) {
                          return Center(
                            child: Column(
                              children: const [
                                Text('Carregando produtos...'),
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                        }
                        if (initialStore.productState is AppStateError) {
                          return const Center(
                            child:
                                Text('Não foi possível carregar os produtos!'),
                          );
                        }
                        initialStore.getProductPriceByMarkets(
                            productIds: initialStore.products
                                .map((element) => element.id)
                                .toList(),
                            marketIds: initialStore.markets
                                .map((element) => element.id)
                                .toList());
                        return Observer(
                          builder: (_) {
                            if (initialStore.allPriceStatus
                                is AppStateLoading) {
                              return Center(
                                child: Column(
                                  children: const [
                                    Text('Calculando preços...'),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              );
                            }
                            if (initialStore.allPriceStatus is AppStateError) {
                              return const Center(
                                child: Text(
                                    'Não foi possível carregar os produtos!'),
                              );
                            }
                            return CustomDataTable(
                              loadMore: false,
                              cellHeight: 100,
                              fixedCornerCell: ButtonShare(
                                onPressed: sharePrices,
                              ),
                              rowsCells: [
                                ...List.generate(initialStore.products.length,
                                    (index) {
                                  return [
                                    Text(initialStore
                                        .products[index].description),
                                    ...initialStore.prices[index]
                                        .map((e) => Center(
                                            child: e.isEmpty || e == 'R\$ 0,00'
                                                ? const Text('Em Falta')
                                                : Text(e)))
                                        .toList()
                                  ];
                                })
                              ],
                              fixedColCells: List.generate(
                                  initialStore.products.length,
                                  (index) => Container(
                                      width: 80,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 90,
                                              child: CachedNetworkImage(
                                                imageUrl: initialStore
                                                    .products[index].imagePath!,
                                                placeholder: (context, url) {
                                                  return Container(
                                                    color: Colors.grey[400],
                                                  );
                                                },
                                                memCacheHeight: 190,
                                                memCacheWidth: 190,
                                                errorWidget: (context, error,
                                                    stackTrace) {
                                                  return CachedNetworkImage(
                                                    imageUrl: initialStore
                                                        .products[index]
                                                        .imagePath!,
                                                    memCacheHeight: 190,
                                                    memCacheWidth: 190,
                                                    errorWidget: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets/img/image_not_found.jpg');
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ]))),
                              fixedRowCells: [
                                Container(),
                                ...List.generate(
                                  initialStore.markets.length,
                                  (index) => InkWell(
                                    onTap: () {
                                      Modular.to.pushNamed('marketDetail/',
                                          arguments:
                                              initialStore.markets[index]);
                                    },
                                    child: Container(
                                      width: 100,
                                      child: FutureBuilder<String>(
                                        builder: ((context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Container(
                                              color: Colors.blueGrey,
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            return CachedNetworkImage(
                                              imageUrl: snapshot.data!,
                                              memCacheWidth: 175,
                                              memCacheHeight: 105,
                                               errorWidget: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets/img/image_not_found.jpg');
                                                    }
                                            );
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }),
                                        future: marketStore.getMarketImage(
                                            id: initialStore.markets[index].id),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              cellBuilder: (data) {
                                return Center(
                                  child: Text(
                                    '$data',
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ))
            ],
          ),
        ));
  }

  sharePrices() {
    List<int> selectedMarkets = [];

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSelectionMarketsPublic(
            selectedMarkets: selectedMarkets,
          );
        }).then((value) {
      if (selectedMarkets.isNotEmpty) {
        String pricesString = '*Mercado Justo* \n';
        String marketsInfo = '';
        for (var i = 0;
            i <
                (initialStore.products.length > 15
                    ? 15
                    : initialStore.products.length);
            i++) {
          pricesString =
              pricesString + '\n _${initialStore.products[i].description}_ \n';
          List<String> prices = initialStore.prices[i];

          for (var j = 0; j < prices.length; j++) {
            if (selectedMarkets.contains(j)) {
              pricesString = pricesString +
                  '${initialStore.markets[j].name}.........${prices[j] == 'R\$ 0,00' ? 'Em Falta' : prices[j]}\n';
            }
          }
        }
        for (var k = 0; k < initialStore.markets.length; k++) {
          if (selectedMarkets.contains(k)) {
            marketsInfo +=
                '\n${initialStore.markets[k].siteAddress}\nCep de Referência....${initialStore.markets[k].address.split(',')[initialStore.markets[k].address.split(',').length - 1]}\n';
          }
        }
        pricesString += marketsInfo;

        Share.share(pricesString +
            '\n\nAcesse o nosso app e tenha uma visualização completa dos melhores preços.');
      }
    });
  }
}
