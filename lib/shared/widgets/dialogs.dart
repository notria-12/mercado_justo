import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/fair_price_store.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/controllers/market_name_store.dart';
import 'package:mercado_justo/shared/repositories/market_name_repository.dart';
import 'package:mercado_justo/shared/utils/input_formaters.dart';
import 'package:mercado_justo/shared/widgets/bottonsheets.dart';

class Dialogs {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                            inputFormatters: [InputFormater.valueMask],
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
                            String newValue =
                                _valueController.text.replaceAll(r',', '.');
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

  void addNewList(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Nova Lista'),
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
                          controller: _nameController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Digite o nome da nova lista',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'O nome é obrigatório';
                            }
                            if (input.length < 8) {
                              return 'O nome precisa ter pelo menos 8 letras';
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
                              Modular.get<ListStore>()
                                  .createNewList(_nameController.text);
                              Modular.to.pop();
                            }
                          },
                          child: const Center(
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
                ),
              ),
            ));
  }
}
