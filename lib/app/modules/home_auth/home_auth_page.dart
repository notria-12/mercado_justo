import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/models/product_model.dart';
import 'package:mercado_justo/shared/widgets/custom_table_widget.dart';

class HomeAuthPage extends StatefulWidget {
  final String title;
  const HomeAuthPage({Key? key, this.title = 'HomeAuthPage'}) : super(key: key);
  @override
  HomeAuthPageState createState() => HomeAuthPageState();
}

class HomeAuthPageState extends State<HomeAuthPage> {
  final _rowsCells = [
    [
      7,
      "Em falta",
      10,
    ],
    [
      10,
      10,
      "Em falta",
    ],
    [5, "Em falta", 5],
    [9, 4, 1],
    ["Em falta", 8, 10],
  ];

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
    if (_rowsCells[0].length < 4) {
      for (int i = 0; i < products.length; i++) {
        _rowsCells[i] = [products[i].name, ..._rowsCells[i]];
      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Início'),
        backgroundColor: Colors.green,
        leading: Container(),
        actions: [
          Container(
            // padding: EdgeInsets.all(8),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
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
              child: CustomDataTable(
                cellHeight: 100,
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
                rowsCells: _rowsCells,
                fixedColCells: List.generate(
                    products.length,
                    (index) => InkWell(
                          onTap: () {
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
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.close)),
                                          alignment: Alignment.topRight,
                                        ),
                                        Container(
                                          height: 200,
                                          child: Image.asset(
                                              products[index].imagePath),
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
                                          products[index].name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text("Ref: ${products[index].ref}"),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Valor médio: R\$ 7,85',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    // height: 600,
                                  );
                                });
                          },
                          child: Container(
                              width: 80,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 90,
                                      child: Image.asset(
                                          products[index].imagePath),
                                    ),
                                  ])),
                        )),
                fixedRowCells: [
                  Container(),
                  ...List.generate(
                      markets.length,
                      (index) => InkWell(
                            onTap: () {
                              Modular.to.pushNamed('/marketDetail/',
                                  arguments: markets[index]);
                            },
                            child: Container(
                              width: 100,
                              child: Image.asset(markets[index].imagePath),
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
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Início'),
          BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined),
              label: 'Minhas listas'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.cartVariant), label: 'Carrinho'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Mais')
        ],
        backgroundColor: Color.fromARGB(255, 240, 241, 241),
        //fixedColor: Colors.grey,
        // selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
