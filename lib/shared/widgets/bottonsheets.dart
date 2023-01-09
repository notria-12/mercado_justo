import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_button_widget.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/controllers/product_to_list_store.dart';
import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/models/product_list_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/widgets/dialogs.dart';

class CustomBottonSheets {
  final store = Modular.get<ListStore>();
  void selectList(BuildContext context) {
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
                  // flex: 8,
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
                        child: Text(
                            'Encontramos problemas ao carregar suas listas'),
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
                                    onPressed: () {
                                      Modular.get<ProductToListStore>()
                                          .addToList(
                                              listId: store
                                                  .product_list[index].id!);
                                      addToList(context);
                                      //TODO atualizando listas para atualizar a quantidade de produtos nas listas( Faz mesmo sentido usar aqui)
                                      store.getAllLists();
                                    },
                                  ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  // OptionsListButton()
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
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomButtom(
                  label: 'Criar nova lista',
                  onPressed: () {
                    Dialogs().addNewList(context);
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ]),
          );
        });
  }

  void selectListToSubtract(BuildContext context,
      {required int listId, required String listName}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Container(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: const Text(
                      'Clique sobre a lista que deseja subtrair os produtos!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  // flex: 8,
                  child: Container(
                // color: Colors.blueGrey,
                child: Observer(
                  builder: (_) {
                    if (store.listState is AppStateLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (store.listState is AppStateError) {
                      return Center(
                        child: Text(
                            'Encontramos problemas ao carregar suas listas'),
                      );
                    }
                    if (store.product_list.isEmpty) {
                      return Center(
                        child:
                            Text('Você precisa ter pelo menos mais uma lista!'),
                      );
                    } else {
                      List<ListModel> productList = store.product_list
                          .where((element) => element.id! != listId)
                          .toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButtom(
                                    label: productList[index].name,
                                    onPressed: () {
                                      store
                                          .subtractList(
                                              mainListId: listId,
                                              secondaryLisId:
                                                  productList[index].id!,
                                              mainListName: listName)
                                          .then((value) {
                                        Modular.to.pop();
                                        Modular.to.pop();
                                      });
                                    },
                                  ),
                                  // SizedBox(
                                  //   width: 5,
                                  // ),
                                  // OptionsListButton()
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                        itemCount: productList.length,
                      );
                    }
                  },
                ),
              )),
              SizedBox(
                height: 5,
              ),
            ]),
          );
        });
  }

  static void addToList(BuildContext context) {
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
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: const Center(
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

  void reportProblemSuccessfull(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "O problema foi reportado com sucesso!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Modular.to.pop();
                        },
                        child: Container(
                          width: 170,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              'OK',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
          );
        });
  }

  void optionsList(BuildContext context,
      {required int listId, required String name}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        builder: (context) {
          return Container(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomButtom(
                          label: 'Excluir Lista',
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.all(16),
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Modular.to.pop();
                                                },
                                                icon: const Icon(Icons.close))
                                          ],
                                        ),
                                        const Text(
                                          'Deseja realmente excluir a lista?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 300,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Modular.to.pop();
                                              Modular.to.pop();
                                              Modular.get<ListStore>()
                                                  .deleteList(listId);
                                            },
                                            child: const Center(
                                              child: Text(
                                                'SIM',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.lightBlue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Renomear Lista',
                          onPressed: () {
                            Dialogs().addNewList(context,
                                value: name, listId: listId);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Subtrair Lista',
                          onPressed: () {
                            selectListToSubtract(context,
                                listId: listId, listName: name);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Duplicar Lista',
                          onPressed: () {
                            store
                                .duplicateList(listId: listId, listName: name)
                                .then((value) {
                              Modular.to.pop();
                              // Modular.to.pop();
                            });
                          },
                        ),
                      ],
                    ),
                  )),
            ]),
          );
        });
  }
}
