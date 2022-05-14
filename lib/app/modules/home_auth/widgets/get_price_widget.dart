import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';

class GetPrice extends StatelessWidget {
  GetPrice({
    Key? key,
    required this.marketId,
    required this.productBarCode,
  }) : super(key: key);

  final int marketId;
  final String productBarCode;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Erro ao buscar");
          }
          if (snapshot.hasData) {
            String data = snapshot.data! as String;
            return Center(
              child: Text(data.isEmpty
                  ? 'Em Falta'
                  : data == 'R\$ 0,00'
                      ? 'Em Falta'
                      : data),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: Modular.get<PriceStore>().getProductPriceByMarket(
          marketId: marketId,
          barCode: productBarCode,
        ));
  }
}
