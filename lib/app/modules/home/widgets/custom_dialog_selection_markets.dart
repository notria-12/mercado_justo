import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home/controllers/initial_controller.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';

class DialogSelectionMarketsPublic extends StatefulWidget {
  List<int> selectedMarkets;

  DialogSelectionMarketsPublic({
    Key? key,
    required this.selectedMarkets,
  }) : super(key: key);

  @override
  State<DialogSelectionMarketsPublic> createState() =>
      _DialogSelectionMarketsPublicState();
}

class _DialogSelectionMarketsPublicState
    extends State<DialogSelectionMarketsPublic> {
  final initialStore = Modular.get<InitialStore>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        titleTextStyle: TextStyle(fontSize: 16),
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'Selecione até 4 mercados para compartilhar:',
                style: TextStyle(
                    color: Colors.black38, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
                onPressed: () {
                  widget.selectedMarkets.clear();
                  Modular.to.pop();
                },
                icon: const Icon(Icons.close))
          ],
        ),
        content: Container(
            height: 400,
            child: Column(children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        initialStore.markets.length,
                        (index) => CheckboxListTile(
                            title: Text(initialStore.markets[index].name),
                            value: widget.selectedMarkets.contains(index),
                            onChanged: (widget.selectedMarkets.length == 4 &&
                                    !widget.selectedMarkets.contains(index))
                                ? null
                                : (value) {
                                    if (widget.selectedMarkets
                                        .contains(index)) {
                                      setState(() {
                                        widget.selectedMarkets.remove(index);
                                      });
                                    } else {
                                      setState(() {
                                        widget.selectedMarkets.add(index);
                                      });
                                    }
                                  }))),
              )),
              ElevatedButton(
                  onPressed: widget.selectedMarkets.length > 0
                      ? () {
                          Modular.to.pop();
                        }
                      : null,
                  child: const Text('Compartilhar'))
            ])));
  }
}
