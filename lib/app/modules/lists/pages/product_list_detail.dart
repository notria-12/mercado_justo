import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/get_price_widget.dart';
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
                Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            children: [
                          TextSpan(text: ' 1 '),
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
                          TextSpan(text: ' R\$ 3,87 '),
                        ],
                            text: 'Valor médio',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)))
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'R\$ 25,90',
                      style:
                          TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {},
                      child: Row(
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
                    Icon(Icons.chevron_left),
                    Container(
                      height: 60,
                      child: Image.network(storeMarket.markets[1].imagePath!),
                    ),
                    Icon(Icons.chevron_right),
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
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: Container(child: Observer(builder: (_) {
              if (storeProductList.productState is AppStateSuccess) {
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
                  rowsCells: [
                    ...List.generate(storeProductList.products.length, (index) {
                      return [
                        Text(storeProductList.products[index].description),
                        ...storeMarket.markets
                            .map((e) => GetPrice(
                                  marketId: e.id,
                                  productBarCode: storeProductList
                                      .products[index].barCode.first,
                                  quantity: storeProductList.quantities[index],
                                ))
                            .toList()
                      ];
                    })
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
              return Container();
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
