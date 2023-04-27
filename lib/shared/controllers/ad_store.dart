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
      ? 'ca-app-pub-6371060274459228/3434682700'
      : 'ca-app-pub-3940256099942544/2934735716';

  String get topBannerHomeId => Platform.isAndroid
      ? 'ca-app-pub-6371060274459228/3434682700'
      : 'ca-app-pub-6371060274459228/7782086168';
  String get bottomBannerHomeId => Platform.isAndroid
      ? 'ca-app-pub-6371060274459228/9102126131'
      : 'ca-app-pub-6371060274459228/9069254971';

  String get topBannerListId => Platform.isAndroid
      ? 'ca-app-pub-6371060274459228/5455305729'
      : 'ca-app-pub-6371060274459228/4086383735';

  String get topBannerCompareId => Platform.isAndroid
      ? 'ca-app-pub-6371060274459228/3894812044'
      : 'ca-app-pub-6371060274459228/1981581681';
  String get bottomBannerCompareId => Platform.isAndroid
      ? 'ca-app-pub-6371060274459228/2855679657'
      : 'ca-app-pub-6371060274459228/1959694096';

  String get topBannerListDetailId => Platform.isAndroid
      ? 'ca-app-pub-6371060274459228/8273821003'
      : 'ca-app-pub-6371060274459228/6822844821';
  String get bottomBannerListDetailId => Platform.isAndroid
      ? 'ca-app-pub-6371060274459228/1351026298'
      : 'ca-app-pub-6371060274459228/7944354808';
}
