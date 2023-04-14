import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/app/modules/lists/filter_store.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/position_store.dart';

class FilterListPage extends StatefulWidget {
  const FilterListPage({Key? key}) : super(key: key);

  @override
  State<FilterListPage> createState() => _FilterListPageState();
}

class _FilterListPageState extends State<FilterListPage> {
  final positionStore = Modular.get<PositionStore>();
  final marketStore = Modular.get<MarketStore>();
  final filterStore = Modular.get<FilterStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filtros',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Mostrar mercados em um raio de:',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black54),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('0Km',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black54)),
              Text('50Km',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black54)),
              Text('100Km',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black54)),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Observer(builder: (_) {
            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  trackShape: CustomTrackShape(),
                  trackHeight: 8.0,
                  inactiveTrackColor: const Color.fromARGB(255, 240, 241, 241),
                  overlayShape: SliderComponentShape.noThumb),
              child: Slider(
                  label: '${filterStore.rating.truncate()}',
                  value: filterStore.rating,
                  divisions: 100,
                  min: 0,
                  max: 100,
                  onChanged: (newRating) {
                    filterStore.rating = newRating;
                  }),
            );
          }),
          const SizedBox(
            height: 8,
          ),
          Observer(builder: (_) {
            return Text(
              'Somente dentro de ${filterStore.rating.truncate()}Km',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black54),
            );
          }),
          const SizedBox(
            height: 25,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Mercados:',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(child: Container(
            child: Observer(builder: (_) {
              return marketStore.filteredMarkets.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/img/not_found.png'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Nenhum mercado encontrado no raio',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black54))
                      ],
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const Divider(),
                            Observer(builder: (_) {
                              return SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                value: Modular.get<MarketStore>()
                                    .filteredMarkets[index]
                                    .isSelectable,
                                onChanged: (onChanged) {
                                  marketStore.marketId =
                                      marketStore.filteredMarkets[index].hashId;
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Row(
                                  children: [
                                    Container(
                                      height: 45,
                                      child: CachedNetworkImage(
                                        imageUrl: marketStore
                                            .filteredMarkets[index].imagePath!,
                                        memCacheHeight: 80,
                                        memCacheWidth: 141,
                                        placeholder: (context, url) {
                                          return Container(
                                            color: Colors.grey[400],
                                          );
                                        },
                                      ),
                                    ),
                                    Text(
                                      ' ${(Geolocator.distanceBetween(positionStore.position!.latitude, positionStore.position!.longitude, marketStore.filteredMarkets[index].latitude, marketStore.filteredMarkets[index].longitude) / 1000).toStringAsFixed(2).replaceAll(r'.', ',')} Km de distância',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Colors.black54),
                                    )
                                  ],
                                ),
                              );
                            }),
                            const Divider(),
                          ],
                        );
                      },
                      itemCount: marketStore.filteredMarkets.length,
                    );
            }),
          ))
        ]),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
