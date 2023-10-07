import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mercado_justo/app/modules/compare/compare_store.dart';
import 'package:mercado_justo/app/modules/home_auth/controllers/average_price_controller.dart';
import 'package:mercado_justo/app/modules/home_auth/controllers/category_controller.dart';
import 'package:mercado_justo/app/modules/home_auth/controllers/problem_controller.dart';
import 'package:mercado_justo/app/modules/home_auth/models/category_model.dart';
import 'package:mercado_justo/app/modules/home_auth/models/problem_model.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_dialog_selection_markets.dart';
import 'package:mercado_justo/app/modules/lists/filter_store.dart';
import 'package:mercado_justo/shared/controllers/ad_store.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';
import 'package:mercado_justo/shared/controllers/product_to_list_store.dart';
import 'package:mercado_justo/shared/controllers/signature_store.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/bottonsheets.dart';
import 'package:mercado_justo/shared/widgets/button_share.dart';
import 'package:mercado_justo/shared/widgets/custom_table_widget.dart';
import 'package:mercado_justo/shared/widgets/load_more_button.dart';
import 'package:mobx/mobx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/auth/auth_controller.dart';
import '../../../../shared/utils/dynamic_links.dart';

class HomeAuthContent extends StatefulWidget {
  const HomeAuthContent({Key? key}) : super(key: key);

  @override
  State<HomeAuthContent> createState() => _HomeAuthContentState();
}

class _HomeAuthContentState extends State<HomeAuthContent> {
  final productStore = Modular.get<ProductStore>();
  final marketStore = Modular.get<MarketStore>();
  PriceStore priceStore = Modular.get<PriceStore>();
  FocusNode searchFocus = FocusNode();

  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  final productToListStore = Modular.get<ProductToListStore>();
  
  final _formKey = GlobalKey<FormState>();

  final _signatureStore = Modular.get<SignatureStore>();

  BannerAd? _bottomBanner;
  BannerAd? _topBanner;
  @override
  void initState() {
    super.initState();

    autorun((_) {
      if (Modular.get<ProblemStore>().problemStatus is AppStateSuccess) {
        CustomBottonSheets().reportProblemSuccessfull(context,
            msg: Modular.get<ProblemStore>().problemType ==
                    'produto_sem_cadastro'
                ? 'O código lido será analisado'
                : null);
      }
    });
    productStore.getAllProducts(initialProducts: true);
    marketStore.getGroupMarkets();
  }

  @override
  void dispose() {
    _bottomBanner!.dispose();
    _topBanner!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var adState = Modular.get<AdStore>();
    adState.adState.then((state) {
      setState(() {
        _bottomBanner = BannerAd(
          adUnitId: adState.topBannerHomeId,
          size: AdSize(
              width: MediaQuery.of(context).size.width.truncate(), height: 50),
          request: AdRequest(),
          listener: BannerAdListener(),
        )..load();

        _topBanner = BannerAd(
          adUnitId: adState.bottomBannerHomeId,
          size: AdSize(
              width: MediaQuery.of(context).size.width.round(), height: 50),
          request: AdRequest(),
          listener: BannerAdListener(),
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: TextFormField(
                      controller: productStore.searchController,
                      focusNode: searchFocus,
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          productStore.onlyButtonLoadMore = false;
                          productStore.getProductsByDescription(
                              description: value);
                          // dialogResultSearchProducts(context);
                          //_searchController.text = '';
                          searchFocus.unfocus();
                        }
                      },
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Informe o nome do produto';
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar por algo...',
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    productStore.onlyButtonLoadMore = false;
                                    productStore.getProductsByDescription(
                                        description: productStore.searchController.text);
                                    // dialogResultSearchProducts(context);
                                    //_searchController.text = '';
                                    searchFocus.unfocus();
                                  }
                                },
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    String barcodeScanRes =
                                        await FlutterBarcodeScanner.scanBarcode(
                                            '#FFFFFF',
                                            'Cancelar',
                                            false,
                                            ScanMode.BARCODE);
                                    if (barcodeScanRes == "-1") {
                                      return;
                                    }

                                    productStore
                                        .getProductByBarcode(
                                            barcode: barcodeScanRes)
                                        .then((value) {
                                      if (value != null) {
                                        showDialogProductDetail(context, value);
                                      } else {
                                        Modular.get<ProblemStore>()
                                            .reportProblem(ProblemModel(
                                                bardCode: barcodeScanRes,
                                                errorType:
                                                    'produto_sem_cadastro'));
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Produto não cadastrado'),
                                                content: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Não existe um produto cadastrado com o código de barra lido($barcodeScanRes)',
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      }
                                    });
                                  },
                                  icon: const Icon(MdiIcons.barcodeScan)),
                            ],
                          )),
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        PageController pageController = PageController();

                        List<Widget> pages = [
                          GeneralCategoriesWidget(
                            controller: pageController,
                          ),
                          SecondaryCategoriesWidget(
                            pageController: pageController,
                            productStore: productStore,
                          )
                        ];

                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            builder: (ctx) {
                              Modular.get<CategoryStore>().canUpdate = false;
                              return PageView(
                                controller: pageController,
                                children: pages,
                              );
                            }).then((value) {
                          if (Modular.get<CategoryStore>().canUpdate) {
                            productStore.onlyButtonLoadMore = false;
                            productStore.isSearch =false;
                            searchFocus.unfocus();
                            productStore.isCategorySearch = true;
                            productStore.getProductsByCategories(
                                categoryName: Modular.get<CategoryStore>()
                                    .selectedCategory!
                                    .description);
                          }
                        });
                      },
                      child: const Text(
                        'Categorias',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton.icon(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.zero)),
                        onPressed: () {
                          Modular.get<FilterStore>().marketId = '';
                          Modular.to.pushNamed('/home_auth/list/filters').then(
                              (value) =>
                                  Modular.get<CompareStore>().reloadList());
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.black87,
                        ),
                        label: const Text(
                          'Filtro',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ))
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
              ],
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                if (productStore.productState is AppStateLoading &&
                    !productStore.onlyButtonLoadMore) {
                  return Center(
                    child: Column(
                      children: const [
                        Text("Os produtos estão sendo carregados..."),
                        SizedBox(
                          height: 8,
                        ),
                        CircularProgressIndicator()
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  );
                } else {
                  if (productStore.products.isNotEmpty) {
                    if (marketStore.filteredMarkets
                        .where((element) => element.isSelectable)
                        .toList()
                        .isEmpty) {
                      var position = Modular.get<PositionStore>().position;

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
                              position != null
                                  ? 'Não há mercados no disponíveis para sua localização'
                                  : 'GPS desligado! Ative o GPS para aparecer os produtos dos supermercados mais próximos de você.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    if (productStore.productState is AppStateSuccess) {
                      priceStore.prices = [];
                      priceStore.getProductPriceByMarkets(
                          productIds:
                              productStore.products.map((e) => e.id).toList(),
                          marketIds: marketStore.filteredMarkets
                              .where((element) => element.isSelectable)
                              .toList()
                              .map((m) => m.id)
                              .toList());
                    }
                    return Observer(
                      builder: (_) {
                        // if (priceStore.allPriceStatus is AppStateLoading) {
                        //   return Center(
                        //     child: Column(
                        //       children: const [
                        //         Text(
                        //             "Aguarde enquanto os preços são carregados..."),
                        //         SizedBox(
                        //           height: 8,
                        //         ),
                        //         CircularProgressIndicator()
                        //       ],
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //     ),
                        //   );
                        // }

                        return CustomDataTable(
                          fixedColWidth: 80.w,
                          loadMoreWidget: productStore.productState
                                  is AppStateLoading
                              ? Container(
                                  height: 40,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : priceStore.allPriceStatus is AppStateLoading
                                  ? Container(
                                      height: 40,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : LoadMoreButton(loadMoreItens: (() {
                                      productStore.onlyButtonLoadMore = true;
                                      if (productStore.isSearch) {
                                        productStore.getProductsByDescription(
                                            description: productStore.searchController.text,
                                            isNewSearch: false);
                                      } else if (productStore
                                          .isCategorySearch) {
                                        final _categoryStore =
                                            Modular.get<CategoryStore>();

                                        productStore.getProductsByCategories(
                                            categoryName: _categoryStore
                                                .selectedCategory!.description,
                                            isNewSearch: false);
                                      } else {
                                        productStore.getAllProducts();
                                      }
                                    })),
                          loadMore: productStore.canLoadMore,
                          cellHeight: 135,
                          fixedCornerCell: ButtonShare(
                            onPressed: sharePrices,
                          ),
                          rowsCells: [
                            ...List.generate(productStore.products.length,
                                (index) {
                              return [
                                Text(productStore.products[index].description),
                                if (priceStore.allPriceStatus
                                    is AppStateLoading)
                                  ...List.generate(
                                      marketStore.filteredMarkets
                                          .where(
                                              (element) => element.isSelectable)
                                          .toList()
                                          .length,
                                      (id) => index >= priceStore.prices.length
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Center(
                                              child: Text(priceStore
                                                          .prices[index][id]
                                                          .isEmpty ||
                                                      priceStore.prices[index]
                                                              [id] ==
                                                          'R\$ 0,00'
                                                  ? 'Em Falta'
                                                  : priceStore.prices[index]
                                                      [id]),
                                            )),
                                if (priceStore.allPriceStatus
                                    is AppStateSuccess)
                                  ...priceStore.prices[index].map((e) => Center(
                                      child: Text(e.isEmpty || e == 'R\$ 0,00'
                                          ? 'Em Falta'
                                          : e)))
                              ];
                            })
                          ],
                          fixedColCells: List.generate(
                              productStore.products.length,
                              (index) => InkWell(
                                    onTap: () {
                                      productStore.findOne(
                                          productStore.products[index].id);
                                      showDialogProductDetail(context,
                                          productStore.products[index]);
                                    },
                                    child: Container(
                                        width: 80,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  height: 90,
                                                  child: CachedNetworkImage(
                                                    imageUrl: productStore
                                                        .products[index]
                                                        .imagePath!,
                                                    memCacheHeight: 150,
                                                    memCacheWidth: 150,
                                                    placeholder:
                                                        (context, url) {
                                                      return Container(
                                                        width: 100,
                                                        color: Colors.grey[400],
                                                      );
                                                    },
                                                    errorWidget: (context,
                                                        error, stackTrace) {
                                                      return CachedNetworkImage(
                                                        imageUrl: productStore
                                                            .products[index]
                                                            .imagePath!,
                                                        memCacheHeight: 150,
                                                        memCacheWidth: 150,
                                                        placeholder:
                                                            (context, url) {
                                                          return Container(
                                                            width: 100,
                                                            color: Colors
                                                                .grey[400],
                                                          );
                                                        },
                                                        errorWidget: (context,
                                                            error, stackTrace) {
                                                          return Image.asset(
                                                              'assets/img/image_not_found.jpg');
                                                        },
                                                      );
                                                    },
                                                  )),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors
                                                                .lightBlue),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 18,
                                                    )),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    'Add Lista',
                                                    style: TextStyle(
                                                        fontSize: 12.sp),
                                                  )
                                                ],
                                              )
                                            ])),
                                  )),
                          fixedRowCells: [
                            Container(),
                            ...List.generate(
                              marketStore.filteredMarkets
                                  .where(
                                      (element) => element.isSelectable == true)
                                  .toList()
                                  .length,
                              (index) => InkWell(
                                onTap: () {
                                  marketStore.findOne(marketStore
                                      .filteredMarkets
                                      .where((element) =>
                                          element.isSelectable == true)
                                      .toList()[index]
                                      .hashId);
                                  Modular.to.pushNamed('marketDetail/',
                                      arguments: marketStore.filteredMarkets
                                          .where((element) =>
                                              element.isSelectable == true)
                                          .toList()[index]);
                                },
                                child: Container(
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: marketStore.filteredMarkets
                                        .where((element) =>
                                            element.isSelectable == true)
                                        .toList()[index]
                                        .imagePath!,
                                    memCacheHeight: 100,
                                    memCacheWidth: 150,
                                    placeholder: (context, url) {
                                      return Container(color: Colors.grey[300]);
                                    },
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
                  } else {
                    return Center(
                      child: Column(
                        children: const [
                          Text("Nenhum produto encontrado!"),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    );
                  }
                }
              },
            ),
          ),
          if (_topBanner != null)
            Observer(builder: (_) {
              return Visibility(
                visible: !(_signatureStore.signature != null &&
                    _signatureStore.signature!.status),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: AdWidget(ad: _bottomBanner!),
                        width: _bottomBanner!.size.width.toDouble(),
                        height: _bottomBanner!.size.height.toDouble(),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  sharePrices() {
    List<int> selectedMarkets = [];

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSelectionMarkets(
            selectedMarkets: selectedMarkets,
          );
        }).then((value) {
      if (selectedMarkets.isNotEmpty) {
        String pricesString = '*Mercado Justo* \n';
        String marketsInfo = '';
        for (var i = 0;
            i <
                (productStore.products.length > 15
                    ? 15
                    : productStore.products.length);
            i++) {
          pricesString =
              pricesString + '\n _${productStore.products[i].description}_ \n';
          List<String> prices = priceStore.prices[i];

          for (var j = 0; j < prices.length; j++) {
            if (selectedMarkets.contains(j)) {
              pricesString = pricesString +
                  '${marketStore.filteredMarkets.where((element) => element.isSelectable == true).toList()[j].name}.........${prices[j] == 'R\$ 0,00' ? 'Em Falta' : prices[j]}\n';
            }
          }
        }
        for (var k = 0;
            k <
                marketStore.filteredMarkets
                    .where((element) => element.isSelectable == true)
                    .toList()
                    .length;
            k++) {
          if (selectedMarkets.contains(k)) {
            marketsInfo +=
                '\n${marketStore.filteredMarkets.where((element) => element.isSelectable == true).toList()[k].siteAddress}\nCep de Referência....${marketStore.filteredMarkets.where((element) => element.isSelectable == true).toList()[k].address.split(',')[marketStore.filteredMarkets[k].address.split(',').length - 1]}\n';
          }
        }
        pricesString += marketsInfo;

        DynamicLinkProvider()
            .createLink(Modular.get<AuthController>().user!.id)
            .then((value) => Share.share(pricesString +
                '\n\nAcesse o nosso app e tenha uma visualização completa dos melhores preços.\n\n$value'));
      }
    });
  }

  Future<dynamic> showDialogProductDetail(
      BuildContext context, Product product) {
    final averagePriceController = Modular.get<AveragePriceStore>();
    averagePriceController.getAveragePrice(
        productId: product.id,
        marketIds: marketStore.filteredMarkets
            .where((element) => element.isSelectable == true)
            .toList()
            .map((e) => e.id)
            .toList());
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close)),
                    alignment: Alignment.topRight,
                  ),
                  Container(
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: product.imagePath!,
                      memCacheHeight: 350,
                      memCacheWidth: 350,
                      placeholder: (context, url) {
                        return Container(
                          width: 250,
                          color: Colors.grey[400],
                        );
                      },
                      errorWidget: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/img/image_not_found.jpg',
                          cacheHeight: 350,
                          cacheWidth: 350,
                        );
                      },
                    ),
                  ),
                  Observer(builder: (_) {
                    return Modular.get<ProblemStore>().problemStatus
                            is AppStateLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero),
                            onPressed: () {
                              Modular.get<ProblemStore>().reportProblem(
                                  ProblemModel(
                                      bardCode: product.barCode[0],
                                      errorType: 'erro_tela_leitor'));
                            },
                            child: Text(
                              'Achou algum erro? clique aqui.',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ));
                  }),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    product.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("Ref: ${product.barCode.first}"),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(builder: (_) {
                    if (averagePriceController.status is AppStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (averagePriceController.status is AppStateSuccess) {
                      return Text(
                        'Valor médio: R\$ ${averagePriceController.averagePrice.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                            // color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      );
                    }
                    return Container();
                  }),
                  const SizedBox(
                    height: 120,
                  ),
                  Observer(builder: (_) {
                    _quantityController.text =
                        productToListStore.value.toString();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => productToListStore.value > 1
                              ? productToListStore.decrement()
                              : null,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: productToListStore.value > 1
                                    ? Colors.lightBlue
                                    : Colors.blueGrey),
                            child: const Center(
                                child: Icon(
                              MdiIcons.minus,
                              color: Colors.white,
                              size: 18,
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Center(
                            child: TextFormField(
                              // initialValue: '1',
                              enabled: false,
                              controller: _quantityController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey)),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () => productToListStore.increment(),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightBlue),
                            child: Center(
                                child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            )),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 240,
                    child: ElevatedButton(
                      child: Center(
                        child: Text(
                          'Selecione ou Adicione uma Lista',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ),
                      onPressed: () {
                        productToListStore.saveProduct(product);
                        CustomBottonSheets().selectList(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Future<dynamic> dialogResultSearchProducts(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   child: const Text('Resultados da pesquisa'),
  //                 ),
  //               ),
  //               InkWell(
  //                 child: const Icon(Icons.close),
  //                 onTap: () {
  //                   Modular.to.pop();
  //                 },
  //               )
  //             ],
  //           ),
  //           content: Observer(
  //             builder: (_) {
  //               if (productStore.searchProductsState is AppStateLoading) {
  //                 return Container(
  //                   height: 300,
  //                   child: Center(child: CircularProgressIndicator()),
  //                 );
  //               }

  //               if (productStore.searchProductsState is AppStateError) {
  //                 return Center(
  //                     child: Text(
  //                         'Infelizmente não foi possível completar a busca'));
  //               }
  //               return Container(
  //                 height: 300,
  //                 width: double.maxFinite,
  //                 child: productStore.searchProductsResult.isEmpty
  //                     ? Container(
  //                         child: Center(
  //                             child: Text(
  //                           'Ops, nenhum produto correspondente encontrado.',
  //                           textAlign: TextAlign.center,
  //                         )),
  //                       )
  //                     : ListView.builder(
  //                         itemBuilder: (context, index) {
  //                           return InkWell(
  //                             onTap: () {
  //                               showDialogProductDetail(context,
  //                                   productStore.searchProductsResult[index]);
  //                             },
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   border: Border.all(
  //                                     color: Colors.black12,
  //                                   )),
  //                               padding: EdgeInsets.symmetric(vertical: 5),
  //                               margin: const EdgeInsets.only(bottom: 5),
  //                               child: ListTile(
  //                                 leading: Container(
  //                                     height: 50,
  //                                     child: Image.network(productStore
  //                                         .searchProductsResult[index]
  //                                         .imagePath!)),
  //                                 title: Text(
  //                                   '${productStore.searchProductsResult[index].description}',
  //                                   overflow: TextOverflow.ellipsis,
  //                                   maxLines: 2,
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                         itemCount: productStore.searchProductsResult.length,
  //                       ),
  //               );
  //             },
  //           ),
  //         );
  //       });
  // }
}

class SecondaryCategoriesWidget extends StatelessWidget {
  SecondaryCategoriesWidget(
      {Key? key, required this.pageController, required this.productStore})
      : super(key: key);

  final PageController pageController;
  final ProductStore productStore;
  final _categoryStore = Modular.get<CategoryStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    pageController.previousPage(
                        duration: Duration(seconds: 1), curve: Curves.ease);
                  },
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Modular.get<CategoryStore>().canUpdate = false;
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            Expanded(child: Observer(
              builder: (context) {
                if (_categoryStore.secondaryCategoriesStatus
                    is AppStateSuccess) {
                  if (_categoryStore.secodaryCategories.isEmpty) {
                    Modular.to.pop();
                    _categoryStore.canUpdate = true;
                  }
                  return ListView.builder(
                    itemBuilder: (buildContext, index) {
                      return InkWell(
                        onTap: () {
                          _categoryStore.canUpdate = true;
                          _categoryStore.selectedCategory =
                              _categoryStore.secodaryCategories[index];

                          Modular.to.pop();
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  Modular.get<CategoryStore>()
                                      .secodaryCategories[index]
                                      .description,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_right_outlined,
                                color: Colors.lightBlue,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount:
                        Modular.get<CategoryStore>().secodaryCategories.length,
                  );
                }
                if (Modular.get<CategoryStore>().secondaryCategoriesStatus
                    is AppStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Container();
              },
            ))
          ],
        ));
  }
}

class GeneralCategoriesWidget extends StatelessWidget {
  PageController controller;

  GeneralCategoriesWidget({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final _categoryStore = Modular.get<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<CategoryModel>>(
        future: _categoryStore.getMainCategories(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Container(
                  child: Text('Erro ao carregar categorias'),
                );
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Selecione uma categoria',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Modular.get<CategoryStore>().canUpdate = false;
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close))
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (buildContext, index) {
                          return InkWell(
                            onTap: () {
                              _categoryStore.selectedCategory =
                                  snapshot.data![index];
                              _categoryStore.getSecondaryCategories(
                                  snapshot.data![index].id);
                              controller.nextPage(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.ease);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index].description,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_right_outlined,
                                    color: Colors.lightBlue,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            default:
              return Container();
          }
        },
      ),
    );
  }
}
