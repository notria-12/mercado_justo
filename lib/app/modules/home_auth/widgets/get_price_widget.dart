import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';

class GetPrice extends StatelessWidget {
  GetPrice({
    Key? key,
    required this.marketId,
    required this.productBarCode,
    this.quantity,
  }) : super(key: key);
  final int? quantity;
  final int marketId;
  final String productBarCode;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Erro ao buscar");
          }
          if (snapshot.hasData) {
            String data = snapshot.data!;
            return Center(
              child: quantity != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data.isEmpty
                            ? 'Em Falta'
                            : data == 'R\$ 0,00'
                                ? 'Em Falta'
                                : data),
                        const SizedBox(
                          height: 20,
                        ),
                        data.isEmpty || data == 'R\$ 0,00'
                            ? Text(
                                'Sugestão?',
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            : Text(
                                'R\$ ${(double.parse(data.replaceAll(r'R$ ', '').replaceAll(r',', '.')) * quantity!).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )
                      ],
                    )
                  : Text(data.isEmpty
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
