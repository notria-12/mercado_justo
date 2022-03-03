import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home/home_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  List<Product> products = [
    Product(
        imagePath: 'assets/img/products/absvt_intimus.jpg',
        name: "Absorvente Intimus Tripla Ação",
        ref: "21213"),
    Product(
        imagePath: 'assets/img/products/always_noite.jpg',
        name: "Absorvente Always Noturno",
        ref: "12131"),
    Product(
        imagePath: 'assets/img/products/carga_gillette.jpg',
        name: "Carga para aparelho de Barbear",
        ref: "21213"),
    Product(
        imagePath: 'assets/img/products/rexona_men.jpg',
        name: "Desodorante aerosol Rexona Men 48h",
        ref: "21213"),
    Product(
        imagePath: 'assets/img/products/seda_ceramidas.jpg',
        name: "Shampoo Seda Ceramidas",
        ref: "21213")
  ];

  List<Market> markets = [
    Market(
        name: 'Pão de Açúcar',
        imagePath: 'assets/img/markets/pão_de_açucar.jpg',
        siteAddress: '',
        addresses: ['R. Teodoro Sampaio, 1240 - São Paulo - SP']),
    Market(
        name: 'Carrefour',
        imagePath: 'assets/img/markets/carrefour.jpg',
        siteAddress: '',
        addresses: ['R. Teodoro Sampaio, 1240 - São Paulo - SP']),
    Market(
        name: 'ASSAÍ',
        imagePath: 'assets/img/markets/assai.png',
        siteAddress: '',
        addresses: ['R. Teodoro Sampaio, 1240 - São Paulo - SP']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bem vindo!'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Expanded(
                  child: Column(
                    children: [
                      Image.asset('assets/img/logo.png'),
                      SizedBox(
                        height: 8,
                      ),
                      RichText(
                          text: const TextSpan(
                              text: 'Economia de verdade',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black),
                              children: [
                            TextSpan(
                                text: ' é aqui!',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ))
                          ])),
                      const Text(
                        'Entre, e compare os preços da sua lista de compras!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 260,
                        height: 45,
                        child: ElevatedButton(
                          child: Text('Entrar / Cadastrar'),
                          onPressed: () {
                            Modular.to.pushNamed('/login/');
                          },
                        ),
                      )
                    ],
                  ),
                  flex: 4,
                ),
              ),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Container(
                    // color: Colors.amber,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowHeight: 100,
                        headingRowHeight: 80,
                        border: TableBorder(
                            verticalInside: BorderSide(
                                color: Color.fromRGBO(245, 245, 245, 1),
                                width: 2)),
                        columns: [
                          DataColumn(
                              label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: Text(
                                  '+ A',
                                  style: TextStyle(color: Colors.lightBlue),
                                )),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(190, 235, 199, 1),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              const Icon(Icons.share_outlined)
                            ],
                          )),
                          ...List.generate(
                              markets.length,
                              (index) => DataColumn(
                                      label: InkWell(
                                    onTap: () {
                                      Modular.to.pushNamed('/marketDetail/',
                                          arguments: markets[index]);
                                    },
                                    child: Container(
                                      width: 100,
                                      child:
                                          Image.asset(markets[index].imagePath),
                                    ),
                                  )))
                        ],
                        rows: List.generate(
                            products.length,
                            (index) => DataRow(cells: [
                                  DataCell(
                                      Container(
                                        width: 180,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Container(
                                              height: 90,
                                              child: Image.asset(
                                                  products[index].imagePath),
                                            )),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    products[index].name,
                                                    // overflow:
                                                    // TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ), onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                Align(
                                                  child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: Icon(Icons.close)),
                                                  alignment: Alignment.topRight,
                                                ),
                                                Container(
                                                  height: 200,
                                                  child: Image.asset(
                                                      products[index]
                                                          .imagePath),
                                                ),
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        minimumSize: Size.zero,
                                                        padding:
                                                            EdgeInsets.zero),
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Achou algum erro? clique aqui.',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  products[index].name,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                    "Ref: ${products[index].ref}"),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  'Valor médio: R\$ 7,85',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                            // height: 600,
                                          );
                                        });
                                  }),
                                  ...List.generate(
                                      markets.length,
                                      (index) => DataCell(Container(
                                            // color: Colors.blueGrey,
                                            child: Center(
                                              child: Text('Em falta'),
                                            ),
                                          )))
                                ])),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
