import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/app/modules/home/controllers/initial_controller.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';
import 'package:mercado_justo/shared/models/market_model.dart';
import 'package:mercado_justo/shared/utils/utils.dart';

class MarketDetail extends StatelessWidget {
  Market market;
  MarketDetail({Key? key, required this.market}) : super(key: key);
  final initialStore = Modular.get<InitialStore>();

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
                    child: Image.network(market.imagePath!),
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
                              onPressed: () {
                                Utils.launchUrl(market.siteAddress);
                              },
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
              ...initialStore
                  .getMarketsByName(market.name)
                  .map((e) => AddressWidget(market: e))
                  .toList()
            ],
          )),
    );
  }
}

class AddressWidget extends StatefulWidget {
  AddressWidget({
    Key? key,
    required this.market,
  }) : super(key: key);

  final Market market;

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final positionStore = Modular.get<PositionStore>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Utils.launchMap(widget.market.latitude.toString(),
            widget.market.longitude.toString());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
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
                    widget.market.address,
                    style: TextStyle(fontSize: 20),
                  ),
                  Observer(builder: (_) {
                    return RichText(
                        text: TextSpan(
                            text: 'Distância: ',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                color: Colors.black),
                            children: [
                          TextSpan(
                              text:
                                  '${(Geolocator.distanceBetween(positionStore.position!.latitude, positionStore.position!.longitude, widget.market.latitude, widget.market.longitude) / 1000).toStringAsFixed(2).replaceAll(r'.', ',')} km',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ))
                        ]));
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
