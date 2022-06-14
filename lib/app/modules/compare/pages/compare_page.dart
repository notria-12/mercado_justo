import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/compare/compare_store.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
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
                  IncrementFont(),
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
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (listStore.productState is AppStateSuccess) {
                          return ListView.builder(
                              itemCount: listStore.products.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                    title: Text(
                                        listStore.products[index].category2!));
                              });
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
