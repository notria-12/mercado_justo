import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/widgets/custom_button_widget.dart';
import 'package:mercado_justo/shared/widgets/dialogs.dart';

class CustomBottonSheets {
  static void selectList(BuildContext context) {
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
                          onPressed: () => addToList(context),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Despensa',
                          onPressed: () => addToList(context),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Churrasco de final de semana',
                          onPressed: () => addToList(context),
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
                      onPressed: () => Dialogs.addNewList(context),
                    ),
                  ],
                ),
              )
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

  static void optionsList(BuildContext context) {
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
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Renomear Lista',
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Subtrair Lista',
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtom(
                          label: 'Duplicar Lista',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )),
            ]),
          );
        });
  }
}
