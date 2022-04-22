import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';

class MarketDetail extends StatelessWidget {
  Market market;
  MarketDetail({Key? key, required this.market}) : super(key: key);
  final marketStore = Modular.get<MarketStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: 110,
                    child: FutureBuilder<String>(
                      builder: ((context, snapshot) {
                        if (snapshot.hasError) {
                          return Container(
                            color: Colors.blueGrey,
                          );
                        }
                        if (snapshot.hasData) {
                          return Image.network(snapshot.data!);
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                      future: marketStore.getMarketImage(id: market.id),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        market.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Visitar o site:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Clique Aqui!',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Escolha o endereço que deseja ir:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: Image.asset('assets/img/turn_right.jpg'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          market.address,
                          style: TextStyle(fontSize: 20),
                        ),
                        RichText(
                            text: const TextSpan(
                                text: 'Distância: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    color: Colors.black),
                                children: [
                              TextSpan(
                                  text: '1,5km',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ))
                            ])),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
