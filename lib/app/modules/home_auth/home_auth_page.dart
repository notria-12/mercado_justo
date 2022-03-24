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
        name:
            "Absorvente Intimus Tripla Proteção Coberturar Estra Suave com Abas 8un",
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
            child: InkWell(
              onTap: () {
                Modular.to.pushNamed('/profile/');
              },
              child: Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
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
                cellHeight: 135,
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
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          textAlign: TextAlign.center,
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
                                              // color: Colors.blue,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 120,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.lightBlue),
                                              child: Center(
                                                  child: Icon(
                                                MdiIcons.minus,
                                                color: Colors.white,
                                                size: 18,
                                              )),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              width: 120,
                                              height: 50,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50),
                                              child: Center(
                                                child: TextFormField(
                                                  initialValue: '1',
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 30,
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
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 240,
                                          child: ElevatedButton(
                                            child: Center(
                                              child: Text(
                                                'Selecione ou Adicione uma Lista',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            onPressed: selectList,
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.lightBlue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                              width: 80,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 90,
                                      child: Image.asset(
                                          products[index].imagePath),
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

  void selectList() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Container(
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Selecione ou Adicione uma lista',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomButtom(
                          label: 'Compras do mês',
                          onPressed: addToList,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Despensa',
                          onPressed: addToList,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Churrasco de final de semana',
                          onPressed: addToList,
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    CustomButtom(
                      label: 'Criar nova lista',
                      onPressed: addNewList,
                    ),
                  ],
                ),
              )
            ]),
          );
        });
  }

  void addToList() {
    Modular.to.pop();
    Modular.to.pop();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Produto adicionado com sucesso!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: Center(
                      child: Text(
                        'OK',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ],
            ),
          );
        });
  }

  void addNewList() {
    Modular.to.pop();
    // Modular.to.pop();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            height: 250,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Modular.to.pop();
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Digite o nome da nova lista',
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pop();
                      selectList();
                    },
                    child: Center(
                      child: Text(
                        'Criar nova lista',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class CustomButtom extends StatelessWidget {
  String label;
  VoidCallback onPressed;

  CustomButtom({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
