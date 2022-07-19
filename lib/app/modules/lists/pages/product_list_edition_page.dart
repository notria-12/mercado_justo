import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';

class ProductEditionPage extends StatefulWidget {
  String listId;
  ProductEditionPage({Key? key, required this.listId}) : super(key: key);

  @override
  State<ProductEditionPage> createState() => _ProductEditionPageState();
}

class _ProductEditionPageState extends State<ProductEditionPage> {
  final storeProductList = Modular.get<ListStore>();
  List<int> auxQuantities = [];
  @override
  Widget build(BuildContext context) {
    auxQuantities = storeProductList.quantities;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  border: TableBorder(
                      verticalInside:
                          BorderSide(color: Colors.grey, width: 0.2)),
                  dataRowHeight: 110,
                  headingRowHeight: 0,
                  horizontalMargin: 8,
                  columnSpacing: 0,
                  columns: const [
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('')),
                    DataColumn(label: Text(''))
                  ],
                  rows: List.generate(
                    storeProductList.products.length,
                    (index) => DataRow(cells: [
                      DataCell(Container(
                        // width: 120,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
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
                                                "Tem Certeza que deseja remover?",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      storeProductList
                                                          .deleteProductOfList(
                                                              listId: int.parse(
                                                                  widget
                                                                      .listId),
                                                              productId:
                                                                  storeProductList
                                                                      .products[
                                                                          index]
                                                                      .productId!);

                                                      Modular.to.pop();
                                                      Modular.to.pop();
                                                    },
                                                    child: Container(
                                                      width: 170,
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child: Center(
                                                        child: Text(
                                                          'Remover',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
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
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 2),
                                      ),
                                      initialValue: storeProductList
                                          .quantities[index]
                                          .toString(),
                                      onChanged: (value) {
                                        auxQuantities[index] = int.parse(value);
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
                          child: Image.network(
                            storeProductList.products[index].imagePath!,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'assets/img/image_not_found.jpg');
                            },
                          ),
                        ),
                      )),
                      DataCell(Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          storeProductList.products[index].description,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        width: 100,
                      ))
                    ]),
                  ),
                ),
              ),
            ),
            Observer(builder: (_) {
              return Container(
                padding: EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed:
                      storeProductList.updateQuantityStatus is AppStateLoading
                          ? null
                          : () {
                              storeProductList.quantities = auxQuantities;
                              storeProductList
                                  .updateQuantity(int.parse(widget.listId));
                            },
                  child:
                      storeProductList.updateQuantityStatus is AppStateLoading
                          ? CircularProgressIndicator()
                          : Text('SALVAR'),
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
  }
}
