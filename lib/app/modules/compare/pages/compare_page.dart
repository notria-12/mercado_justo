import 'package:flutter/material.dart';
import 'package:mercado_justo/shared/widgets/button_share.dart';
import 'package:mercado_justo/shared/widgets/increment_font.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text('Total dos melhores preços dos mercados selecionados'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'R\$ 00,00',
                style:
                    const TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IncrementFont(),
                  ButtonShare(),
                  Icon(
                    Icons.delete_outline_outlined,
                    size: 28,
                  )
                ],
              )
            ],
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'O seu carrinho está vazio.',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Selecione a lista de compras desejada, faça um filtro de quais mercados você quer que apareça e veja os melhores preços em cada um deles',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )
            ],
          ))
        ],
      ),
    );
  }
}
