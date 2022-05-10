import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/widgets/bottomsheets.dart';

class Dialogs {
  static void addNewList(BuildContext context) {
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
                height: 200,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: 300,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Digite o nome da nova lista',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 16)),
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
                          Modular.to.pop();
                          CustomBottonSheets.selectList(context);
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
            ));
  }
}
