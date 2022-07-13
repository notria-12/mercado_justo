import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/compare/compare_store.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_store.dart';
import 'package:mercado_justo/shared/controllers/fair_price_store.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/controllers/market_name_store.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/custom_table_widget.dart';
import 'package:mercado_justo/shared/widgets/dialogs.dart';
import 'package:mercado_justo/shared/widgets/fixed_corner_table_widget.dart';

class ProductListDetailsPage extends StatefulWidget {
  ListModel listModel;
  ProductListDetailsPage({Key? key, required this.listModel}) : super(key: key);

  @override
  State<ProductListDetailsPage> createState() => _ProductListDetailsPageState();
}

class _ProductListDetailsPageState extends State<ProductListDetailsPage> {
  final storeMarket = Modular.get<MarketStore>();
  final storeProductList = Modular.get<ListStore>();
  final storeFairPrice = Modular.get<FairPriceStore>();
  double price = 0.0;
  @override
  void initState() {
    storeProductList.getProducts(widget.listModel.id!);

    super.initState();
  }

  @override
  void dispose() {
    storeProductList.prices = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.listModel.name,
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Observer(
          builder: (_) {
            return (storeProductList.productState is AppStateSuccess &&
                    storeProductList.prices.isNotEmpty)
                ? storeMarket.filteredMarkets.isEmpty
                    ? Column(
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
                              Text('Ajuste o raio de distância clicando '),
                              InkWell(
                                child: Text(
                                  'aqui',
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                onTap: () {
                                  Modular.to
                                      .pushNamed('/home_auth/list/filters')
                                      .then((value) {
                                    storeProductList.prices = [];
                                    storeProductList
                                        .getProducts(widget.listModel.id!);
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      )
                    : productsAndPricesTable()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Aguarde um instante...'),
                        SizedBox(
                          height: 5,
                        ),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Column productsAndPricesTable() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Valor total da lista por Mercado',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
            ),
            Observer(builder: (_) {
              if (storeProductList.isFairPrice &&
                  storeProductList.marketSelected == -1) {
                return FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Visibility(
                        visible: storeProductList.products.length -
                                storeFairPrice.fairPricesFromList.length >
                            0,
                        child: Column(
                          children: [
                            RichText(
                                text: TextSpan(
                                    children: [
                                  TextSpan(
                                      text:
                                          ' ${storeProductList.products.length - storeFairPrice.fairPricesFromList.length} '),
                                  const TextSpan(text: 'item')
                                ],
                                    text: 'Falta',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                            RichText(
                                text: TextSpan(
                                    children: [
                                  TextSpan(
                                      text:
                                          ' R\$ ${storeProductList.getAverageMissingProducts(storeFairPrice.fairPricesFromList.map((e) => e['product_id'] as int).toList()).toStringAsFixed(2)} '),
                                ],
                                    text: 'Valor médio',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                  future: storeFairPrice.getFairPricesFromList(
                      listId: widget.listModel.id!),
                );
              }
              return Visibility(
                visible: storeProductList.missingProducts['missingItens'] != 0,
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            children: [
                          TextSpan(
                              text:
                                  ' ${storeProductList.missingProducts['missingItens']} '),
                          const TextSpan(text: 'item')
                        ],
                            text: 'Falta',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))),
                    RichText(
                        text: TextSpan(
                            children: [
                          TextSpan(
                              text:
                                  ' R\$ ${storeProductList.missingProducts['average']} '),
                        ],
                            text: 'Valor médio',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              );
            })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(builder: (_) {
                  return (storeProductList.isFairPrice &&
                          storeProductList.marketSelected == -1)
                      ? Text(
                          'R\$ ${storeProductList.getTotalPriceForMyFairPrice(storeFairPrice.fairPricesFromList).toStringAsFixed(2).replaceAll(r'.', ',')}',
                          style: const TextStyle(
                              fontSize: 38, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'R\$ ${storeProductList.totalPrice.toStringAsFixed(2).replaceAll(r'.', ',')}',
                          style: const TextStyle(
                              fontSize: 38, fontWeight: FontWeight.bold),
                        );
                }),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    Modular.get<CompareStore>()
                        .addToComparePage(widget.listModel.id!);
                    Modular.get<HomeAuthStore>().currentIndex = 2;
                    Modular.to.pop();
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.lightBlue),
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
                        'add a comparação',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  child: const Icon(Icons.chevron_left),
                  onTap: () {
                    storeProductList.setMarketSelected(-1);
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Observer(builder: (_) {
                  if (storeProductList.marketSelected == -1) {
                    return FutureBuilder<String?>(
                        future: Modular.get<MarketNameStore>()
                            .getMarketName(listId: widget.listModel.id!),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Container();
                              }
                              if (snapshot.hasData) {
                                return InkWell(
                                  onTap: () {
                                    Dialogs()
                                        .addNewMarketName(context,
                                            listId: widget.listModel.id!,
                                            name: snapshot.data!)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        snapshot.data!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    Dialogs()
                                        .addNewMarketName(context,
                                            listId: widget.listModel.id!)
                                        .then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 60,
                                    child: const Center(
                                      child: Text(
                                        'Inserir nome do Mercado',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                );
                              }

                            default:
                              return Container();
                          }
                        });
                  } else {
                    return Container(
                      height: 60,
                      width: 100,
                      child: Image.network(storeMarket
                          .filteredMarkets[storeProductList.marketSelected]
                          .imagePath!),
                    );
                  }
                }),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                    child: Icon(Icons.chevron_right),
                    onTap: () {
                      storeProductList.setMarketSelected(1);
                    }),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonOptionsListDetail(
              label: 'Filtro',
              onTap: () {
                Modular.get<MarketStore>().marketId = '';
                Modular.to.pushNamed('/home_auth/list/filters').then((value) {
                  storeProductList.prices = [];
                  storeProductList.getProducts(widget.listModel.id!);
                });
              },
            ),
            Observer(builder: (_) {
              return ButtonOptionsListDetail(
                label: 'Meu Preço Justo',
                tapped: storeProductList.isFairPrice,
                onTap: () {
                  storeProductList.isFairPrice = !storeProductList.isFairPrice;
                  if (storeProductList.isFairPrice) {
                    storeProductList.marketSelected = -1;
                  } else {
                    storeProductList.marketSelected = 0;
                  }
                },
              );
            }),
            ButtonOptionsListDetail(
              label: 'Editar',
              onTap: () {
                Modular.to
                    .pushNamed('/home_auth/list/edit/${widget.listModel.id!}');
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: Container(
                child: CustomDataTable(
          loadMore: false,
          fixedCornerCell: const FixedCorner(),
          cellHeight: 130,
          fixedColCells: storeProductList.products
              .map((e) => Stack(children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        // margin: EdgeInsets.all(8),
                        child: Image.network(e.imagePath!),
                        height: 90,
                        // width: 80,
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
                            '${storeProductList.quantities[storeProductList.products.indexOf(e)]}x',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      alignment: Alignment.topRight,
                    ),
                  ]))
              .toList(),
          fixedRowCells: [
            Container(),
            if (storeProductList.isFairPrice)
              FutureBuilder<String?>(
                  future: Modular.get<MarketNameStore>()
                      .getMarketName(listId: widget.listModel.id!),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Container();
                        }
                        if (snapshot.hasData) {
                          return Container(
                            width: 100,
                            height: 60,
                            child: Center(
                              child: Text(
                                snapshot.data!,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: 100,
                            child: const Center(
                              child: Text('Nome do mercado ',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )),
                            ),
                          );
                        }

                      default:
                        return Container();
                    }
                  }),
            ...List.generate(
                storeMarket.filteredMarkets.length,
                (index) => InkWell(
                      onTap: () {
                        Modular.to.pushNamed('/home/marketDetail/',
                            arguments: storeMarket.filteredMarkets[index]);
                      },
                      child: Container(
                        width: 100,
                        child: Image.network(
                            storeMarket.filteredMarkets[index].imagePath!),
                      ),
                    ))
          ],
          rowsCells: List.generate(
              storeProductList.prices.length,
              (index) => [
                    Text(storeProductList.products[index].description),
                    if (storeProductList.isFairPrice)
                      FutureBuilder<double?>(
                          future: storeFairPrice.getFairPrice(
                              listId: widget.listModel.id!,
                              productId:
                                  storeProductList.products[index].productId!),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );

                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return Container();
                                }
                                if (snapshot.hasData) {
                                  price = snapshot.data!;
                                  return InkWell(
                                    onTap: () {
                                      Dialogs()
                                          .addNewFairPrice(context,
                                              listId: widget.listModel.id!,
                                              productId: storeProductList
                                                  .products[index].productId!,
                                              value: snapshot.data)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("R\$ " +
                                            snapshot.data!
                                                .toStringAsFixed(2)
                                                .replaceAll(r'.', ',')),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'R\$ ${(snapshot.data! * storeProductList.quantities[index]).toStringAsFixed(2).replaceAll(r'.', ',')}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      Dialogs()
                                          .addNewFairPrice(context,
                                              listId: widget.listModel.id!,
                                              productId: storeProductList
                                                  .products[index].productId!)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: const Text(
                                      'Inserir Preço ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }

                              default:
                                return Container();
                            }
                          }),
                    ...storeProductList.prices[index]
                        .map((e) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(e.isEmpty
                                    ? 'Em Falta'
                                    : e == 'R\$ 0,00'
                                        ? 'Em Falta'
                                        : e),
                                const SizedBox(
                                  height: 20,
                                ),
                                e.isEmpty || e == 'R\$ 0,00'
                                    ? const Text(
                                        'Sugestão?',
                                        style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : Text(
                                        'R\$ ${(double.parse(e.replaceAll(r'R$ ', '').replaceAll(r',', '.')) * storeProductList.quantities[index]).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                              ],
                            ))
                        .toList()
                  ]),
          cellBuilder: (data) {
            return Center(
              child: Text(
                '$data',
              ),
            );
          },
        )))
      ],
    );
  }
}

class ButtonOptionsListDetail extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool? tapped;
  ButtonOptionsListDetail({
    Key? key,
    required this.label,
    this.onTap,
    this.tapped = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: tapped! ? Colors.green : Color.fromARGB(255, 240, 241, 241),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: tapped! ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
