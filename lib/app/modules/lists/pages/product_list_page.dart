import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_button_widget.dart';
import 'package:mercado_justo/app/modules/login/pages/code_by_email_page.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/bottonsheets.dart';
import 'package:mercado_justo/shared/widgets/dialogs.dart';
import 'package:mobx/mobx.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends ModularState<ProductListPage, ListStore> {
  @override
  void initState() {
    store.getAllLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Selecione ou Adicione uma lista',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
            flex: 9,
            child: Container(
              // color: Colors.blueGrey,
              child: Observer(
                builder: (_) {
                  if (store.listState is AppStateLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (store.listState is AppStateError) {
                    return Center(
                      child:
                          Text('Encontramos problemas ao carregar suas listas'),
                    );
                  }
                  if (store.product_list.isEmpty) {
                    return Center(
                      child: Text('Você ainda não criou nenhuma lista!'),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButtom(
                                  label: store.product_list[index].name,
                                  subTitle: FutureBuilder<int>(
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          "${snapshot.data!} Produtos",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white70),
                                        );
                                      }
                                      return Container();
                                    },
                                    future: store.getProductsByList(
                                        store.product_list[index].id!),
                                  ),
                                  onPressed: () {
                                    Modular.to.pushNamed(
                                      '/home_auth/list/',
                                      arguments: store.product_list[index],
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                OptionsListButton(
                                    listId: store.product_list[index].id!)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                      itemCount: store.product_list.length,
                    );
                  }
                },
              ),
            )),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomButtom(
                  label: 'Criar nova lista',
                  onPressed: () {
                    Dialogs().addNewList(context);
                  },
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget OptionsListButton({required int listId}) {
    return InkWell(
      onTap: () => CustomBottonSheets.optionsList(context, listId: listId),
      child: Container(
        height: 50,
        width: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.lightBlue),
        child: const Center(
            child: Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 38,
        )),
      ),
    );
  }
}
