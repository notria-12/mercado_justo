import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mercado_justo/app/modules/home_auth/controllers/problem_controller.dart';
import 'package:mercado_justo/app/modules/home_auth/models/problem_model.dart';
import 'package:mercado_justo/shared/controllers/fair_price_store.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/controllers/market_name_store.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/utils.dart';

class Dialogs {
  Future addNewMarketName(BuildContext context,
      {required int listId, String? name}) {
    final _formValuekey = GlobalKey<FormState>();
    final _valueController = TextEditingController();
    if (name != null) {
      _valueController.text = name.toString();
    }
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: const Text('Insira o nome para o mercado'),
                    ),
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              content: Container(
                child: Form(
                  key: _formValuekey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 241, 241),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: _valueController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                hintText: 'Insira o nome',
                                border: InputBorder.none),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: Text('Excluir Nome Salvo'),
                          onPressed: () {
                            Modular.get<MarketNameStore>()
                                .deleteMarketName(listId: listId)
                                .then((value) => Modular.to.pop());
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: Text('Salvar'),
                          onPressed: () {
                            if (name != null) {
                              Modular.get<MarketNameStore>()
                                  .updateMarketName(
                                      name: _valueController.text,
                                      listId: listId)
                                  .then((value) => Modular.to.pop());
                            } else {
                              Modular.get<MarketNameStore>()
                                  .saveMarketName(
                                      name: _valueController.text,
                                      listId: listId)
                                  .then((value) => Modular.to.pop());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  Future addNewFairPrice(BuildContext context,
      {required int listId, required int productId, double? value}) {
    final _formValuekey = GlobalKey<FormState>();
    final _valueController = TextEditingController();
    if (value != null) {
      _valueController.text = value.toString();
    }
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: const Text('Insira o valor unitário do produto'),
                    ),
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              content: Container(
                child: Form(
                  key: _formValuekey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 241, 241),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            inputFormatters: [
                              CurrencyTextInputFormatter(
                                  locale: 'pt_br', symbol: 'R\$')
                            ],
                            controller: _valueController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: '00,00', border: InputBorder.none),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: Text('Excluir Preço Salvo'),
                          onPressed: () {
                            Modular.get<FairPriceStore>()
                                .deleteFairPrice(
                                    listId: listId, productId: productId)
                                .then((value) => Modular.to.pop());
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: Text('Salvar'),
                          onPressed: () {
                            String newValue = _valueController.text
                                .replaceAll(r'R$', '')
                                .trim()
                                .replaceAll(r',', '.');

                            if (value != null) {
                              Modular.get<FairPriceStore>()
                                  .updateFairPrice(
                                      value: double.parse(newValue),
                                      listId: listId,
                                      productId: productId)
                                  .then((value) => Modular.to.pop());
                            } else {
                              Modular.get<FairPriceStore>()
                                  .saveFairPrice(
                                      value: double.parse(newValue),
                                      listId: listId,
                                      productId: productId)
                                  .then((value) => Modular.to.pop());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  void addNewList(BuildContext context, {String? value, int? listId}) {
    final TextEditingController _problemTextController =
        TextEditingController();
    final _formKey = GlobalKey<FormState>();
    if (value != null) {
      _problemTextController.text = value;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value != null ? 'Editar Lista' : 'Nova Lista'),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              content: Container(
                padding: const EdgeInsets.all(16),
                height: 210,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: 300,
                        child: TextFormField(
                          controller: _problemTextController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Digite o nome da nova lista',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'O nome é obrigatório';
                            }
                            if (input.length < 3) {
                              return 'O nome precisa ter pelo menos 3 letras';
                            }
                          },
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            final formState = _formKey.currentState!;
                            if (formState.validate()) {
                              formState.save();
                              if (value != null) {
                                Modular.get<ListStore>().updateListName(
                                    listId: listId!,
                                    newName: _problemTextController.text);
                                Modular.to.pop();
                                Modular.to.pop();
                              } else {
                                Modular.get<ListStore>()
                                    .createNewList(_problemTextController.text);
                                Modular.to.pop();
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              value != null ? 'Salvar' : 'Criar nova lista',
                              style: const TextStyle(fontSize: 20),
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
                ),
              ),
            ));
  }

  void socialNetworkDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nossas Redes Sociais',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nos siga em nossas Redes sociais e fique por dentro de todas as novidades:',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Utils.launchUrl(
                              "https://instagram.com/mercadojustoapp?igshid=ZDdkNTZiNTM=");
                        },
                        child: Column(
                          children: const [
                            Icon(
                              MdiIcons.instagram,
                              size: 50,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Instagram',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Utils.launchUrl(
                              "https://www.facebook.com/MercadoJustoApp/");
                        },
                        child: Column(
                          children: const [
                            Icon(
                              MdiIcons.facebook,
                              size: 50,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Facebook',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Utils.launchUrl("https://vm.tiktok.com/ZMYUW4tsW/");
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset('assets/img/tiktok.png'),
                              height: 50,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Tiktok',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  Future<dynamic> requestLocalizationDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/img/location_image.jpeg'),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'O mercado justo precisa da sua localização para listar os mercados mais próximos de você',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Dê permissão e descubra onde comprar barato!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Negar',
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Modular.get<PositionStore>().getCurrentPosition();
                        },
                        child: const Text('Aceitar')),
                  ],
                )
              ],
            ),
          );
        });
  }

  void reportProblem(BuildContext context, {required String barCode}) {
    final TextEditingController _problemTextController =
        TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Problema'),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              content: Container(
                padding: const EdgeInsets.all(16),
                height: 260,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: 300,
                        child: TextFormField(
                          controller: _problemTextController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Informe o problema',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'O campo não pode está vazio';
                            }
                            if (input.length < 5) {
                              return 'O nome precisa ter pelo menos 5 letras';
                            }
                          },
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            final formState = _formKey.currentState!;
                            if (formState.validate()) {
                              Modular.get<ProblemStore>().reportProblem(
                                  ProblemModel(
                                      bardCode: barCode,
                                      errorType: _problemTextController.text));
                            }
                          },
                          child: Observer(builder: (_) {
                            return Modular.get<ProblemStore>().problemStatus
                                    is AppStateLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(
                                    child: Text(
                                      'Reportar',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  );
                          }),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
