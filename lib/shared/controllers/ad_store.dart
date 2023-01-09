// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';

part 'ad_store.g.dart';

class AdStore = _AdStoreBase with _$AdStore;

abstract class _AdStoreBase with Store {
  Future<InitializationStatus> adState;

  _AdStoreBase({
    required this.adState,
  });

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
}
