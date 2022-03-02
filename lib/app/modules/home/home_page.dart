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
                          onPressed: () {},
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
                                    color: Color.fromRGBO(190, 235, 199, 1),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Icon(Icons.share_outlined)
                            ],
                          )),
                          ...List.generate(
                              markets.length,
                              (index) => DataColumn(
                                      label: Container(
                                    width: 100,
                                    child:
                                        Image.asset(markets[index].imagePath),
                                  )))
                        ],
                        rows: List.generate(
                            products.length,
                            (index) => DataRow(cells: [
                                  DataCell(
                                    Container(
                                      // color: Colors.blueAccent,
                                      // height: 100,
                                      width: 180,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Container(
                                            // color: Colors.amberAccent,
                                            height: 90,
                                            // width: 90,
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
                                    ),
                                  ),
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
