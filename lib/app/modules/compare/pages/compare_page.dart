import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/compare/compare_store.dart';
import 'package:mercado_justo/app/modules/lists/pages/product_list_detail.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/button_share.dart';
import 'package:mercado_justo/shared/widgets/increment_font.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends ModularState<ComparePage, CompareStore> {
  final listStore = Modular.get<ListStore>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          const Text(
            'Total dos melhores preços dos mercados selecionados',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'R\$ 0,00',
                style:
                    const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ButtonOptionsListDetail(
                    label: 'Filtro',
                    onTap: () {
                      Modular.get<MarketStore>().marketId = '';
                      Modular.to.pushNamed('/home_auth/list/filters');
                    },
                  ),
                  ButtonShare(),
                  Icon(
                    Icons.delete_outline_outlined,
                    size: 28,
                  )
                ],
              )
            ],
          ),
          Expanded(
              child: FutureBuilder<int?>(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    listStore.getProducts(snapshot.data!);
                    return Observer(
                      builder: (_) {
                        if (listStore.productState is AppStateLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (listStore.productState is AppStateSuccess &&
                            Modular.get<MarketStore>().markets.isNotEmpty) {
                          return FutureBuilder(
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );

                                case ConnectionState.done:
                                  if (snapshot.hasError) {
                                    return Text('Deu erro meu parceiro');
                                  }
                                  return Container(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        Market market =
                                            Modular.get<MarketStore>()
                                                .markets
                                                .firstWhere((market) =>
                                                    store.getFairPrice[index][0]
                                                        ['market_id'] ==
                                                    market.hashId);
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 80,
                                                  child: Image.network(
                                                      market.imagePath!),
                                                ),
                                                Expanded(
                                                    child: Text(market.address))
                                              ],
                                            ),
                                            ...store
                                                .groupProducts(store
                                                    .getFairPrice[index]
                                                    .map((e) => Product.fromMap(
                                                        e['product_id']))
                                                    .toList())
                                                .map((e) => ExpansionTile(
                                                      title:
                                                          Text(e[0].category2!),
                                                      children: [
                                                        DataTable(
                                                          border:
                                                              const TableBorder(
                                                            verticalInside:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 0.2),
                                                          ),
                                                          dataRowHeight: 110,
                                                          headingRowHeight: 0,
                                                          horizontalMargin: 8,
                                                          columnSpacing: 0,
                                                          columns: const [
                                                            DataColumn(
                                                                label:
                                                                    Text('')),
                                                            DataColumn(
                                                                label:
                                                                    Text('')),
                                                            DataColumn(
                                                                label: Text(''))
                                                          ],
                                                          rows: List.generate(
                                                            e.length,
                                                            (i) => DataRow(
                                                                cells: [
                                                                  DataCell(
                                                                    Container(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          80,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image.network(
                                                                              e[i].imagePath!)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  DataCell(
                                                                      Container(
                                                                    // width: double.maxFinite,
                                                                    height: 80,
                                                                    child: Text(
                                                                      e[i].description,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  )),
                                                                  DataCell(
                                                                      Container(
                                                                    width: 120,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                            children: [
                                                                              Icon(Icons.edit_outlined),
                                                                              Text('editar item')
                                                                            ]),
                                                                      ],
                                                                    ),
                                                                  ))
                                                                ]),
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                            // ...List.generate(
                                            //     store.getFairPrice[index]
                                            //         .length, (i) {
                                            //   var map =
                                            //       store.getFairPrice[index][i]
                                            //           ['product_id'];
                                            //   Product product =
                                            //       Product.fromMap(map);

                                            //   return ExpansionTile(
                                            //       title:
                                            //           Text(product.category2!));
                                            // })
                                          ],
                                        );
                                      },
                                      itemCount: store.getFairPrice.length,
                                    ),
                                  );
                                default:
                                  return Container();
                              }
                            },
                            future: store.getProductsPrices(listStore.products),
                          );
                          // return ListView.builder(
                          //     itemCount: listStore.groupProducts.length,
                          //     itemBuilder: (context, index) {
                          //       return ExpansionTile(
                          //           title: Text(listStore
                          //               .groupProducts[index][0].category2!),
                          //           children: [
                          //             DataTable(
                          //               border: const TableBorder(
                          //                 verticalInside: BorderSide(
                          //                     color: Colors.grey, width: 0.2),
                          //               ),
                          //               dataRowHeight: 110,
                          //               headingRowHeight: 0,
                          //               horizontalMargin: 8,
                          //               columnSpacing: 0,
                          //               columns: const [
                          //                 DataColumn(label: Text('')),
                          //                 DataColumn(label: Text('')),
                          //                 DataColumn(label: Text(''))
                          //               ],
                          //               rows: List.generate(
                          //                 listStore.groupProducts[index].length,
                          //                 (i) => DataRow(cells: [
                          //                   DataCell(
                          //                     Container(
                          //                       width: 100,
                          //                       height: 80,
                          //                       child: Row(
                          //                         children: [
                          //                           Image.network(listStore
                          //                               .groupProducts[index][i]
                          //                               .imagePath!)
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   DataCell(Container(
                          //                     // width: double.maxFinite,
                          //                     height: 80,
                          //                     child: Text(
                          //                       listStore
                          //                           .groupProducts[index][i]
                          //                           .description,
                          //                       style: TextStyle(
                          //                           color: Colors.black),
                          //                     ),
                          //                   )),
                          //                   DataCell(Container(
                          //                     width: 120,
                          //                     child: Column(
                          //                       children: [
                          //                         Row(children: [
                          //                           Icon(Icons.edit_outlined),
                          //                           Text('editar item')
                          //                         ]),
                          //                       ],
                          //                     ),
                          //                   ))
                          //                 ]),
                          //               ),
                          //             ),
                          //           ]);
                          //     });
                        }
                        return Container();
                      },
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'O seu carrinho está vazio.',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        'Selecione a lista de compras desejada, faça um filtro de quais mercados você quer que apareça e veja os melhores preços em cada um deles!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      )
                    ],
                  );

                default:
                  return Container();
              }
            },
            future: store.getCurrentList(),
          ))
        ],
      ),
    );
  }
}
