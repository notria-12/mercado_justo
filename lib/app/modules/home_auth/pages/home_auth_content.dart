import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/get_price_widget.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';
import 'package:mercado_justo/shared/controllers/product_to_list_store.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/bottonsheets.dart';
import 'package:mercado_justo/shared/widgets/custom_table_widget.dart';
import 'package:mercado_justo/shared/widgets/fixed_corner_table_widget.dart';
import 'package:mercado_justo/shared/widgets/load_more_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeAuthContent extends StatefulWidget {
  const HomeAuthContent({Key? key}) : super(key: key);

  @override
  State<HomeAuthContent> createState() => _HomeAuthContentState();
}

class _HomeAuthContentState extends State<HomeAuthContent> {
  final productStore = Modular.get<ProductStore>();
  final marketStore = Modular.get<MarketStore>();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  final productToListStore = Modular.get<ProductToListStore>();
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: TextFormField(
                      controller: _searchController,
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          productStore.onlyButtonLoadMore = false;
                          productStore.getProductsByDescription(
                              description: value);
                          // dialogResultSearchProducts(context);
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
                                        description: _searchController.text);
                                    // dialogResultSearchProducts(context);
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
                                    productStore
                                        .getProductByBarcode(
                                            barcode: barcodeScanRes)
                                        .then((value) =>
                                            showDialogProductDetail(
                                                context, value));
                                  },
                                  icon: Icon(MdiIcons.barcodeScan)),
                            ],
                          )),
                    ),
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
          Expanded(
            child: Observer(
              builder: (_) {
                if (productStore.productState is AppStateLoading &&
                    !productStore.onlyButtonLoadMore) {
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
                  if (productStore.products.isNotEmpty) {
                    return CustomDataTable(
                      loadMoreWidget:
                          productStore.productState is AppStateLoading
                              ? Container(
                                  height: 40,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : LoadMoreButton(loadMoreItens: (() {
                                  productStore.onlyButtonLoadMore = true;
                                  if (productStore.isSearch) {
                                    productStore.getProductsByDescription(
                                        description: _searchController.text,
                                        isNewSearch: false);
                                  } else {
                                    productStore.getAllProducts();
                                  }
                                })),
                      loadMoreColumns: () {
                        marketStore.getAllMarkets();
                      },
                      loadMore: productStore.canLoadMore,
                      cellHeight: 135,
                      fixedCornerCell: FixedCorner(),
                      rowsCells: [
                        ...List.generate(productStore.products.length, (index) {
                          return [
                            Text(productStore.products[index].description),
                            ...marketStore.markets
                                .map((e) => GetPrice(
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
                                  showDialogProductDetail(
                                      context, productStore.products[index]);
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
                                                  color: Colors.greenAccent,
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    'Imagem indisponível!',
                                                    style:
                                                        TextStyle(fontSize: 18),
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
                                    Modular.to.pushNamed('/home/marketDetail/',
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
                  } else {
                    return Center(
                      child: Column(
                        children: [
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
        ],
      ),
    );
  }

  Future<dynamic> showDialogProductDetail(
      BuildContext context, Product product) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return SingleChildScrollView(
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
                  child: Image.network(product.imagePath!),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero),
                    onPressed: () {},
                    child: Text(
                      'Achou algum erro? clique aqui.',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )),
                SizedBox(
                  height: 8,
                ),
                Text(
                  product.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Ref: ${product.barCode.first}"),
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
                            decoration:
                                const InputDecoration(border: InputBorder.none),
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
                              shape: BoxShape.circle, color: Colors.lightBlue),
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
                    child: const Center(
                      child: Text(
                        'Selecione ou Adicione uma Lista',
                        style: TextStyle(color: Colors.white),
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
