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

    store.getCurrentList();
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
          Observer(builder: (context) {
            double sum = 0;
            if (store.getFairPrice.isNotEmpty) {
              store.getFairPrice.forEach((element) {
                sum += element.map((e) {
                  return e['value'] * e['quantity'] as double;
                }).reduce((value, element) => value + element);
              });
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'R\$ ${sum.toStringAsFixed(2).replaceAll(r'.', ',')}',
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
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
                                        const Text("A tela atual ficará vazia"),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                store.removeListInComparePage();
                                                Modular.to.pop();
                                              },
                                              child: Container(
                                                width: 170,
                                                padding: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color: Colors.lightBlue,
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
                                                    style:
                                                        TextStyle(fontSize: 18),
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
                        Icons.delete_outline_outlined,
                        size: 28,
                      ),
                    )
                  ],
                )
              ],
            );
          }),
          Expanded(child: Observer(
            builder: (context) {
              if (store.listId != null) {
                listStore.getProducts(store.listId!);
                return Observer(
                  builder: (_) {
                    if (listStore.productState is AppStateLoading) {
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
                    if (listStore.productState is AppStateSuccess &&
                        Modular.get<MarketStore>().markets.isNotEmpty) {
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
                                return Text(
                                    'Obtivemos problemas ao montar a lista de comparação');
                              }

                              return Container(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    Market market = Modular.get<MarketStore>()
                                        .markets
                                        .firstWhere((market) =>
                                            store.getFairPrice[index][0]
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
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 70,
                                                child: Image.network(
                                                    market.imagePath!),
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    market.address,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text('Distância: 1,5km'),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    'R\$ ${store.getFairPrice[index].where((element) => element['market_id'] == market.hashId).map((e) {
                                                          return e['value'] *
                                                                  e['quantity']
                                                              as double;
                                                        }).reduce((value, element) => value + element).toStringAsFixed(2).replaceAll(r'.', ',')}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.green[700]),
                                                  )
                                                ],
                                              ))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        ...store
                                            .groupProducts(store
                                                .getFairPrice[index]
                                                .map((fairPrice) =>
                                                    Product.fromMap(fairPrice[
                                                        'product_id']))
                                                .toList())
                                            .map((e) => Container(
                                                  decoration: const BoxDecoration(
                                                      border: Border(
                                                          top: BorderSide(
                                                              width: 0.3,
                                                              color: Colors
                                                                  .black54))),
                                                  child: ExpansionTile(
                                                    maintainState: true,
                                                    collapsedBackgroundColor:
                                                        Color.fromARGB(
                                                            255, 240, 241, 241),
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(e[0].category!),
                                                        Text(
                                                            ' R\$ ${store.getFairPrice[index].where((element) => element['product_id']['categoria_1'] == e[0].category).map((e) => e['quantity'] * e['value'] as double).reduce((value, element) => value + element).toStringAsFixed(2).replaceAll(r'.', ',')}'),
                                                      ],
                                                    ),
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
                                                              label: Text('')),
                                                          DataColumn(
                                                              label: Text('')),
                                                          DataColumn(
                                                              label: Text(''))
                                                        ],
                                                        rows: List.generate(
                                                            e.length, (i) {
                                                          var row = store
                                                              .getFairPrice[
                                                                  index]
                                                              .firstWhere((element) =>
                                                                  element['product_id']
                                                                      ['_id'] ==
                                                                  e[i].id);
                                                          return DataRow(
                                                              cells: [
                                                                DataCell(
                                                                  Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              80,
                                                                          child:
                                                                              Image.network(e[i].imagePath!),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              25,
                                                                          width:
                                                                              35,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                                              border: Border.all(color: Colors.black26)),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              '${row['quantity']}x',
                                                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          4,
                                                                      vertical:
                                                                          2),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        e[i].description,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.w500),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            3,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      Text(
                                                                        'R\$ ${row['value']}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      Text(
                                                                        'R\$ ${(row['value'] * row['quantity']).toString().replaceAll(r'.', ',')}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )),
                                                                DataCell(
                                                                    Container(
                                                                  width: 120,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return AlertDialog(
                                                                                  insetPadding: EdgeInsets.symmetric(horizontal: 4),
                                                                                  content: Container(
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        DataTable(
                                                                                          border: TableBorder(verticalInside: BorderSide(color: Colors.grey, width: 0.2)),
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
                                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                                                                            builder: (context) {
                                                                                                              return Container(
                                                                                                                padding: EdgeInsets.all(16),
                                                                                                                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                                                  const SizedBox(
                                                                                                                    height: 10,
                                                                                                                  ),
                                                                                                                  const Text(
                                                                                                                    "Tem Certeza que deseja remover?",
                                                                                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                    height: 4,
                                                                                                                  ),
                                                                                                                  const SizedBox(
                                                                                                                    height: 8,
                                                                                                                  ),
                                                                                                                  Row(
                                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                    children: [
                                                                                                                      InkWell(
                                                                                                                        onTap: () {
                                                                                                                          store.removeProductFromList(e[i].productId!);

                                                                                                                          Modular.to.pop();
                                                                                                                          Modular.to.pop();
                                                                                                                        },
                                                                                                                        child: Container(
                                                                                                                          width: 170,
                                                                                                                          padding: EdgeInsets.all(16),
                                                                                                                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                                                                          child: Center(
                                                                                                                            child: Text(
                                                                                                                              'Remover',
                                                                                                                              style: TextStyle(color: Colors.white, fontSize: 18),
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
                                                                                                                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),
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
                                                                                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
                                                                                                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                                                                                                  child: Image.network(e[i].imagePath!),
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
                                                                                        ),
                                                                                        Observer(builder: (_) {
                                                                                          return Container(
                                                                                            padding: EdgeInsets.all(4),
                                                                                            child: ElevatedButton(
                                                                                              onPressed: store.newQuantity == null
                                                                                                  ? null
                                                                                                  : () {
                                                                                                      store.updateQuantity(e[i].productId!);
                                                                                                      Modular.to.pop();
                                                                                                    },
                                                                                              child: Text('SALVAR'),
                                                                                              style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
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
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
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
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child:
                                                                            ProductCheckBox(),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ))
                                                              ]);
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                ))
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
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
            },
          ))
        ],
      ),
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
