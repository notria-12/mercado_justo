import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/custom_table_widget.dart';
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
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Valor total da lista por Mercado',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500),
                ),
                Observer(builder: (_) {
                  return Visibility(
                    visible:
                        storeProductList.missingProducts['missingItens'] != 0,
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                children: [
                              TextSpan(
                                  text:
                                      ' ${storeProductList.missingProducts['missingItens']} '),
                              TextSpan(text: 'item')
                            ],
                                text: 'Falta',
                                style: TextStyle(
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
                                style: TextStyle(
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
                      return Text(
                        'R\$ ${storeProductList.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 38, fontWeight: FontWeight.bold),
                      );
                    }),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {},
                      child: Row(
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
                          SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'add carrinho',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.chevron_left),
                      onTap: () {
                        storeProductList.setMarketSelected(-1);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Observer(builder: (_) {
                      return Container(
                        height: 60,
                        width: 100,
                        child: Image.network(storeMarket
                            .markets[storeProductList.marketSelected]
                            .imagePath!),
                      );
                    }),
                    SizedBox(
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
                    Modular.to.pushNamed('/home_auth/list/filters');
                  },
                ),
                ButtonOptionsListDetail(
                  label: 'Meu Preço Justo',
                ),
                ButtonOptionsListDetail(
                  label: 'Editar',
                  onTap: () {
                    Modular.to.pushNamed(
                        '/home_auth/list/edit/${widget.listModel.id!}');
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: Container(child: Observer(builder: (_) {
              if (storeProductList.productState is AppStateSuccess &&
                  storeProductList.prices.isNotEmpty) {
                return CustomDataTable(
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(color: Colors.black26)),
                                child: Center(
                                  child: Text(
                                    '${storeProductList.quantities[storeProductList.products.indexOf(e)]}x',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              alignment: Alignment.topRight,
                            ),
                          ]))
                      .toList(),
                  fixedRowCells: [
                    Container(),
                    ...List.generate(
                        storeMarket.markets.length,
                        (index) => InkWell(
                              onTap: () {
                                Modular.to.pushNamed('/home/marketDetail/',
                                    arguments: storeMarket.markets[index]);
                              },
                              child: Container(
                                width: 100,
                                child: Image.network(
                                    storeMarket.markets[index].imagePath!),
                              ),
                            ))
                  ],
                  rowsCells: List.generate(
                      storeProductList.prices.length,
                      (index) => [
                            Text(storeProductList.products[index].description),
                            ...storeProductList.prices[index]
                                .map((e) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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

                  // storeProductList.prices
                  //     .map((e) => [...e.map((e) =>  Text(e)).toList()])
                  //     .toList(),
                  //  [
                  //   ...List.generate(storeProductList.products.length, (index) {
                  //     return [
                  //       Text(storeProductList.products[index].description),
                  //       ...storeMarket.markets
                  //           .map((e) => Text('Em Falta')
                  //               // GetPrice(
                  //               //   marketId: e.id,
                  //               //   productBarCode: storeProductList
                  //               //       .products[index].barCode.first,
                  //               //   quantity: storeProductList.quantities[index],
                  //               // ),
                  //               )
                  //           .toList()
                  //     ];
                  //   })
                  // ],
                  cellBuilder: (data) {
                    return Center(
                      child: Text(
                        '$data',
                      ),
                    );
                  },
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Aguarde um instante...'),
                    SizedBox(
                      height: 5,
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              );
            })))
          ],
        ),
      ),
    );
  }
}

class ButtonOptionsListDetail extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  ButtonOptionsListDetail({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 241, 241),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
