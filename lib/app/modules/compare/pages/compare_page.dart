import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mercado_justo/app/modules/compare/compare_store.dart';
import 'package:mercado_justo/app/modules/lists/filter_store.dart';
import 'package:mercado_justo/app/modules/lists/pages/product_list_detail.dart';
import 'package:mercado_justo/shared/controllers/ad_store.dart';
import 'package:mercado_justo/shared/controllers/config_store.dart';

import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/dynamic_links.dart';
import 'package:mercado_justo/shared/widgets/button_share.dart';
import 'package:mobx/mobx.dart';

import 'package:share_plus/share_plus.dart';

import '../../../../shared/auth/auth_controller.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends ModularState<ComparePage, CompareStore> {
  final positionStore = Modular.get<PositionStore>();
  final marketStore = Modular.get<MarketStore>();
  final _signatureStore = Modular.get<SignatureStore>();
  BannerAd? _topBanner;
  BannerAd? _bottomBanner;
  @override
  void initState() {
    super.initState();

    store.getCurrentList();
    // autorun((_){
    //     if(store.listId != null){
    //       store.getProducts(store.listId!);
    //     }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var adState = Modular.get<AdStore>();
    adState.adState.then((state) {
      setState(() {
        _topBanner = BannerAd(
          adUnitId: adState.topBannerCompareId,
          size: AdSize(
              width: MediaQuery.of(context).size.width.truncate(), height: 50),
          request: AdRequest(),
          listener: BannerAdListener(),
        )..load();

        _bottomBanner = BannerAd(
          adUnitId: adState.bottomBannerCompareId,
          size: AdSize(
              width: MediaQuery.of(context).size.width.truncate(), height: 50),
          request: AdRequest(),
          listener: BannerAdListener(),
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          if (_topBanner != null)
            Observer(builder: (_) {
              return Visibility(
                visible: !(_signatureStore.signature != null &&
                    _signatureStore.signature!.status),
                child: Align(
                  child: Container(
                    alignment: Alignment.center,
                    child: AdWidget(ad: _topBanner!),
                    width: _topBanner!.size.width.toDouble(),
                    height: _topBanner!.size.height.toDouble(),
                  ),
                ),
              );
            }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Total dos melhores preços dos mercados selecionados',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
            ),
          ),
          Observer(builder: (context) {
            double sum = 0;
            if (store.getFairPrice.isNotEmpty) {
              store.getFairPrice.forEach((element) {
                sum += element.map((e) {
                  return e['value'] * e['quantity'] as double;
                }).reduce((value, element) => value + element);
              });
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (_signatureStore.signature != null &&
                          _signatureStore.signature!.status)
                      ? Text(
                          'R\$ ${sum.toStringAsFixed(2).replaceAll(r'.', ',')}',
                          style: TextStyle(
                              fontSize: 30.h, fontWeight: FontWeight.bold),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock,
                                color: Colors.green,
                              ),
                              Text(
                                'Valor total bloqueado',
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 16.sp),
                              )
                            ],
                          ),
                        ),
                  Row(
                    children: [
                      ButtonOptionsListDetail(
                        label: 'Filtro',
                        onTap: () {
                          Modular.get<FilterStore>().marketId = '';
                          Modular.to
                              .pushNamed('/home_auth/list/filters')
                              .then((value) => store.reloadList());
                        },
                      ),
                      ButtonShare(
                        onPressed: store.getFairPrice.isNotEmpty &&
                                (_signatureStore.signature != null &&
                                    _signatureStore.signature!.status)
                            ? sharePrices
                            : null,
                        size: 20.sp,
                      ),
                      InkWell(
                        onTap: () {
                          if (store.getFairPrice.isNotEmpty)
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Tem certeza que deseja remover a lista de melhores preços?",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                              "A tela atual ficará vazia"),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  store
                                                      .removeListInComparePage();
                                                  Modular.to.pop();
                                                },
                                                child: Container(
                                                  width: 170,
                                                  padding: EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Center(
                                                    child: Text(
                                                      'Remover',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
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
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Center(
                                                    child: Text(
                                                      'Cancelar',
                                                      style: TextStyle(
                                                          fontSize: 18),
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
                        child: Icon(
                          Icons.delete_outline_outlined,
                          size: 25.sp,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Observer(
              builder: (context) {
                if (store.listId != null) {
                  store.getProducts(store.listId!);
                  return Observer(
                    builder: (_) {
                      if (store.productState is AppStateLoading) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Carregando produtos...'),
                              SizedBox(
                                height: 8,
                              ),
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                      if (store.productState is AppStateSuccess &&
                          Modular.get<MarketStore>()
                              .filteredMarkets
                              .where((element) => element.isSelectable == true)
                              .toList()
                              .isNotEmpty) {
                                
                        return FutureBuilder(
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text('Calculando preço justo...'),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    CircularProgressIndicator(),
                                  ],
                                ));

                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return const Text(
                                      'Obtivemos problemas ao montar a lista de PoupaMais');
                                }
                                
                                var auxFairPrice = store.getFairPrice;
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    
                                    Market market = Modular.get<MarketStore>()
                                        .filteredMarkets
                                        .where(
                                            (element) => element.isSelectable)
                                        .toList()
                                        .firstWhere((market) =>
                                            auxFairPrice[index][0]
                                                ['market_id'] ==
                                            market.hashId);
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 240, 241, 241))),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 4),
                                          child: 
                                          // Observer(builder: (_) {
                                            // return
                                             Row(
                                              children: [
                                                Container(
                                                  height: 80,
                                                  width: 70,
                                                  child: (_signatureStore
                                                                  .signature !=
                                                              null &&
                                                          _signatureStore
                                                              .signature!
                                                              .status)
                                                      ? CachedNetworkImage(
                                                          imageUrl: market
                                                              .imagePath!,
                                                          memCacheHeight: 150,
                                                          memCacheWidth: 180,
                                                        )
                                                      : Container(
                                                          child: const Center(
                                                          child: Text(
                                                            'SEJA PREMIUM',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .lightBlue),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                          ),
                                                        )),
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      market.address,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Observer(builder: (_) {
                                                      return Text(
                                                          'Distância: ${(Geolocator.distanceBetween(positionStore.position!.latitude, positionStore.position!.longitude, market.latitude, market.longitude) / 1000).toStringAsFixed(2).replaceAll(r'.', ',')} km');
                                                    }),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    (_signatureStore.signature !=
                                                                null &&
                                                            _signatureStore
                                                                .signature!
                                                                .status)
                                                        ? Text(
                                                            'R\$ ${auxFairPrice[index].where((element) => element['market_id'] == market.hashId).map((e) {
                                                                  return e['value'] *
                                                                          e['quantity']
                                                                      as double;
                                                                }).reduce((value, element) => value + element).toStringAsFixed(2).replaceAll(r'.', ',')}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                        .green[
                                                                    700]),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left:
                                                                        16.0),
                                                            child: Icon(
                                                                Icons.lock),
                                                          )
                                                  ],
                                                ))
                                              ],
                                            )
                                          // }),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Observer(
                                          builder: (_) {
                                            if (Modular.get<ConfigStore>()
                                                    .separetedByCategory ==
                                                false) {
                                              return productsTable(
                                                  auxFairPrice[index]
                                                      .map((fairPrice) =>
                                                          Product.fromMap(
                                                              fairPrice[
                                                                  'product_id']))
                                                      .toList(),
                                                  index, auxFairPrice);
                                            } else {
                                              return Column(
                                                children: [
                                                  ...store
                                                      .groupProducts(auxFairPrice[index]
                                                          .map((fairPrice) =>
                                                              Product.fromMap(
                                                                  fairPrice[
                                                                      'product_id']))
                                                          .toList())
                                                      .map((e) => Container(
                                                            decoration: const BoxDecoration(
                                                                border: Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            0.3,
                                                                        color:
                                                                            Colors.black54))),
                                                            child:
                                                                ExpansionTile(
                                                              maintainState:
                                                                  true,
                                                              collapsedBackgroundColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      240,
                                                                      241,
                                                                      241),
                                                              title: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(e[0]
                                                                      .category!),
                                                                  (_signatureStore.signature !=
                                                                              null &&
                                                                          _signatureStore
                                                                              .signature!.status)
                                                                      ? Text(
                                                                          ' R\$ ${auxFairPrice[index].where((element) => element['product_id']['categoria_1'] == e[0].category).map((e) => e['quantity'] * e['value'] as double).reduce((value, element) => value + element).toStringAsFixed(2).replaceAll(r'.', ',')}',
                                                                        )
                                                                      : Icon(Icons
                                                                          .lock),
                                                                ],
                                                              ),
                                                              children: [
                                                                productsTable(
                                                                    e, index, auxFairPrice)
                                                              ],
                                                            ),
                                                          ))
                                                ],
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: auxFairPrice.length,
                                );
                              default:
                                return Container();
                            }
                          },
                          future: store.getProductsPrices(store.products),
                        );
                      }
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Com base na sua localização atual, infelizmente não foi possível listar os mercados!',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Ajuste o raio de distância ou altere sua localização '),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'O seu PoupaMais está vazio.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    const Text(
                      'Selecione a lista de compras desejada e clique em: ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightBlue),
                            child: const Center(
                                child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'add a PoupaMais',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Assim você verá os melhores preços de cada supermercado.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ],
                );
              },
            ),
          )),
          if (_bottomBanner != null)
            Observer(builder: (_) {
              return Visibility(
                visible: !(_signatureStore.signature != null &&
                    _signatureStore.signature!.status),
                child: Container(
                  alignment: Alignment.center,
                  child: AdWidget(ad: _bottomBanner!),
                  width: _bottomBanner!.size.width.toDouble(),
                  height: _bottomBanner!.size.height.toDouble(),
                ),
              );
            }),
        ],
      ),
    );
  }

  sharePrices() {
    String pricesString = '*Mercado Justo* \n';
    String marketsInfo = '';
    for (int i = 0; i < store.getFairPrice.length; i++) {
      Market market = Modular.get<MarketStore>()
          .filteredMarkets
          .where((element) => element.isSelectable)
          .toList()
          .firstWhere((market) =>
              store.getFairPrice[i][0]['market_id'] == market.hashId);
      marketsInfo +=
          '\n${market.siteAddress}\nCep de Referência....${market.address.split(',')[market.address.split(',').length - 1]}\n';
      pricesString += '\n *${market.name}*\n';
      for (int j = 0; j < store.getFairPrice[i].length; j++) {
        Product product =
            Product.fromMap(store.getFairPrice[i][j]['product_id']);
        pricesString += '\n _${product.description}_\n';
        pricesString +=
            'R\$ ${(store.getFairPrice[i][j]['value'] as double).toStringAsFixed(2).replaceAll('.', ',')}\n';
      }
    }
    pricesString += '\nSite e/ou local de referência:\n';
    pricesString += marketsInfo;
    DynamicLinkProvider()
        .createLink(Modular.get<AuthController>().user!.id)
        .then((value) => Share.share(pricesString +
            '\n\nAcesse o nosso app e tenha uma visualização completa dos melhores preços.\n\n$value'));
  }

  DataTable productsTable(List<Product> products, int index, List<List<Map<String, dynamic>>> fairPrice) {
    return DataTable(
      border: const TableBorder(
        verticalInside: BorderSide(color: Colors.grey, width: 0.2),
      ),
      dataRowHeight: 111.h,
      headingRowHeight: 0,
      horizontalMargin: 8,
      columnSpacing: 0,
      columns: const [
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
        DataColumn(label: Text(''))
      ],
      rows: List.generate(products.length, (i) {
        var row = fairPrice[index].firstWhere(
            (element) => element['product_id']['_id'] == products[i].id);
        return DataRow(cells: [
          DataCell(
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 90.w,
                    height: 80,
                    child: CachedNetworkImage(
                      imageUrl: products[i].imagePath!,
                      memCacheHeight: 150,
                      memCacheWidth: 180,
                      errorWidget: (context, error, stackTrace) {
                        return Image.asset('assets/img/image_not_found.jpg');
                      },
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    height: 25,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.black26)),
                    child: Center(
                      child: Text(
                        '${row['quantity']}x',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
              ],
            ),
          ),
          DataCell(Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  products[i].description,
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 2,
                ),
                (_signatureStore.signature != null &&
                        _signatureStore.signature!.status)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'R\$ ${(row['value'] as double).toStringAsFixed(2).replaceAll(r'.', ',')}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            'R\$ ${(row['value'] * row['quantity'] as double).toStringAsFixed(2).replaceAll(r'.', ',')}',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : Expanded(
                        child: Center(
                        child: Icon(Icons.lock),
                      ))
              ],
            ),
          )),
          DataCell(Container(
            width: 110.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.symmetric(horizontal: 4),
                            content: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  productsTableEdit(context, products, i, row),
                                  Observer(builder: (_) {
                                    return Container(
                                      padding: EdgeInsets.all(4),
                                      child: ElevatedButton(
                                        onPressed: store.newQuantity == null
                                            ? null
                                            : () {
                                                store.updateQuantity(
                                                    products[i].productId!);
                                                Modular.to.pop();
                                              },
                                        child: Text('SALVAR'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.lightBlue),
                                      ),
                                      height: 50,
                                      width: 300,
                                    );
                                  })
                                ],
                              ),
                            ),
                          );
                        }).then((value) => store.newQuantity = null);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.edit_outlined,
                          size: 15,
                          color: Colors.lightBlue,
                        ),
                        Text('editar item'),
                      ]),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ProductCheckBox(),
                )
              ],
            ),
          ))
        ]);
      }),
    );
  }

  DataTable productsTableEdit(
      BuildContext context, List<Product> e, int i, Map<String, dynamic> row) {
    return DataTable(
      border: TableBorder(
          verticalInside: BorderSide(color: Colors.grey, width: 0.2)),
      dataRowHeight: 110,
      headingRowHeight: 0,
      horizontalMargin: 8,
      columnSpacing: 0,
      columns: const [
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
        DataColumn(label: Text(''))
      ],
      rows: [
        DataRow(cells: [
          DataCell(Container(
            // width: 120,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
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
                                    "Tem Certeza que deseja remover?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          store.removeProductFromList(
                                              e[i].productId!);

                                          Modular.to.pop();
                                          Modular.to.pop();
                                        },
                                        child: Container(
                                          width: 170,
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                            child: Text(
                                              'Remover',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
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
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
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
                  child: const Icon(
                    Icons.delete_outline,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Quantidade',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      height: 35,
                      width: 70,
                      child: Center(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                          ),
                          initialValue: row['quantity'].toString(),
                          onChanged: (value) {
                            store.newQuantity = int.parse(value);
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 3,
                ),
              ],
            ),
          )),
          DataCell(Container(
            height: 100,
            // width: 130,
            // padding: const EdgeInsets.all(8),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: e[i].imagePath!,
                memCacheHeight: 180,
                memCacheWidth: 180,
                errorWidget: (context, error, stackTrace) {
                  return Image.asset('assets/img/image_not_found.jpg');
                },
              ),
            ),
          )),
          DataCell(Container(
            padding: EdgeInsets.all(8),
            child: Text(
              e[i].description,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
            width: 100,
          ))
        ])
      ],
    );
  }
}

class ProductCheckBox extends StatefulWidget {
  ProductCheckBox({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCheckBox> createState() => _ProductCheckBoxState();
}

class _ProductCheckBoxState extends State<ProductCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        });
  }
}
