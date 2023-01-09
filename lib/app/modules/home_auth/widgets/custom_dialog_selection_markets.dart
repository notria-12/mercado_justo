import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';

class DialogSelectionMarkets extends StatefulWidget {
  List<int> selectedMarkets;

  DialogSelectionMarkets({
    Key? key,
    required this.selectedMarkets,
  }) : super(key: key);

  @override
  State<DialogSelectionMarkets> createState() => _DialogSelectionMarketsState();
}

class _DialogSelectionMarketsState extends State<DialogSelectionMarkets> {
  final marketStore = Modular.get<MarketStore>();

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
                        marketStore.filteredMarkets.length,
                        (index) => CheckboxListTile(
                            title:
                                Text(marketStore.filteredMarkets[index].name),
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
