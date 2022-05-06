import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_button_widget.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/custom_table_widget.dart';
import 'package:mercado_justo/shared/widgets/load_more_button.dart';

class HomeAuthContent extends StatefulWidget {
  const HomeAuthContent({Key? key}) : super(key: key);

  @override
  State<HomeAuthContent> createState() => _HomeAuthContentState();
}

class _HomeAuthContentState extends State<HomeAuthContent> {
  final productStore = Modular.get<ProductStore>();
  final marketStore = Modular.get<MarketStore>();

  @override
  void initState() {
    productStore.getAllProducts();
    marketStore.getGroupMarkets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar por algo...',
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(MdiIcons.barcodeScan))),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Categorias',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(
            flex: 11,
            child: Observer(
              builder: (_) {
                if (productStore.products.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
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
                  return CustomDataTable(
                    loadMoreWidget: productStore.productState is AppStateLoading
                        ? Container(
                            height: 40,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : LoadMoreButton(loadMoreItens: (() {
                            productStore.getAllProducts();
                          })),
                    loadMoreColumns: () {
                      marketStore.getAllMarkets();
                    },
                    loadMore: true,
                    cellHeight: 135,
                    fixedCornerCell: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 35,
                            width: 35,
                            child: Center(
                                child: Text(
                              '+ A',
                              style: TextStyle(color: Colors.lightBlue),
                            )),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(190, 235, 199, 1),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Colors.grey,
                            size: 28,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    rowsCells: [
                      ...List.generate(productStore.products.length, (index) {
                        return [
                          Text(productStore.products[index].description),
                          ...marketStore.markets
                              .map((e) => GetPrice(
                                    productStore: productStore,
                                    marketId: e.id,
                                    productBarCode: productStore
                                        .products[index].barCode.first,
                                  ))
                              .toList()
                        ];
                      })
                    ],
                    fixedColCells: List.generate(
                        productStore.products.length,
                        (index) => InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              child: Image.network(productStore
                                                  .products[index].imagePath!),
                                            ),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    minimumSize: Size.zero,
                                                    padding: EdgeInsets.zero),
                                                onPressed: () {},
                                                child: Text(
                                                  'Achou algum erro? clique aqui.',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12),
                                                )),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              productStore
                                                  .products[index].description,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                "Ref: ${productStore.products[index].ref}"),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'Valor médio: R\$ 7,85',
                                              style: TextStyle(
                                                  // color: Colors.blue,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 120,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.lightBlue),
                                                  child: Center(
                                                      child: Icon(
                                                    MdiIcons.minus,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: 120,
                                                  height: 50,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 50),
                                                  child: Center(
                                                    child: TextFormField(
                                                      initialValue: '1',
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
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
                                              ],
                                            ),
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
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                onPressed: selectList,
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.lightBlue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                  width: 80,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 90,
                                          child: Image.network(
                                            productStore
                                                .products[index].imagePath!,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.amber,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'Whoops!',
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
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
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text('Add Lista')
                                          ],
                                        )
                                      ])),
                            )),
                    fixedRowCells: [
                      Container(),
                      ...List.generate(
                          marketStore.markets.length,
                          (index) => InkWell(
                                onTap: () {
                                  Modular.to.pushNamed('/marketDetail/',
                                      arguments: marketStore.markets[index]);
                                },
                                child: Container(
                                  width: 100,
                                  child: Image.network(
                                      marketStore.markets[index].imagePath!),
                                ),
                              ))
                    ],
                    cellBuilder: (data) {
                      return Center(
                        child: Text(
                          '$data',
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          // Expanded(
          //     child: Container(
          //   height: 40,
          //   child: Icon(Icons.add),
          // ))
        ],
      ),
    );
  }

  // FutureBuilder<String> futureProductImage(int index) {
  //   return FutureBuilder<String>(
  //     builder: ((context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Container(
  //           color: Colors.blueGrey,
  //         );
  //       }
  //       if (snapshot.hasData) {
  //         return Image.network(snapshot.data!);
  //       }
  //       return Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     }),
  //     future: productStore.getProductImage(
  //         barCode: productStore.products[index].barCode.first),
  //   );
  // }

  // Widget getProductImage(int index) {
  //   return Observer(
  //     builder: ((context) {
  //       if (productStore.productState is AppStateError) {
  //         return Container(
  //           color: Colors.blueGrey,
  //         );
  //       }
  //       if (productStore.productState is AppStateSuccess) {
  //         return Image.network(snapshot.data!);
  //       }
  //       return Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     }),

  //   );
  // }

  void selectList() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Container(
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Selecione ou Adicione uma lista',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomButtom(
                          label: 'Compras do mês',
                          onPressed: addToList,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Despensa',
                          onPressed: addToList,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Churrasco de final de semana',
                          onPressed: addToList,
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    CustomButtom(
                      label: 'Criar nova lista',
                      onPressed: addNewList,
                    ),
                  ],
                ),
              )
            ]),
          );
        });
  }

  void addNewList() {
    Modular.to.pop();
    // Modular.to.pop();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            height: 250,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Modular.to.pop();
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Digite o nome da nova lista',
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pop();
                      selectList();
                    },
                    child: Center(
                      child: Text(
                        'Criar nova lista',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ],
            ),
          );
        });
  }

  void addToList() {
    Modular.to.pop();
    Modular.to.pop();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Produto adicionado com sucesso!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: Center(
                      child: Text(
                        'OK',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class GetPrice extends StatelessWidget {
  GetPrice({
    Key? key,
    required this.productStore,
    required this.marketId,
    required this.productBarCode,
  }) : super(key: key);

  final ProductStore productStore;
  final int marketId;
  final String productBarCode;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Erro ao buscar");
          }
          if (snapshot.hasData) {
            String data = snapshot.data! as String;
            return Center(
              child: Text(data.isEmpty
                  ? 'Em Falta'
                  : data == 'R\$ 0,00'
                      ? 'Em Falta'
                      : data),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: Modular.get<PriceStore>().getProductPriceByMarket(
          marketId: marketId,
          barCode: productBarCode,
        ));
  }
}
