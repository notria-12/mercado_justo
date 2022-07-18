import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/config_store.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Observer(builder: (_) {
            return SwitchListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: Modular.get<ConfigStore>().separetedByCategory,
              onChanged: (value) {
                Modular.get<ConfigStore>().setSeparetedByCategory(value);
              },
              title: const Text('Separar produtos por categoria'),
            );
          })
        ],
      ),
    );
  }
}
