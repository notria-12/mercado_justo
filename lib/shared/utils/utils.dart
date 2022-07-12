import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void launchEmail() async {
    String _url =
        "mailto:conta@mercadojustoapp.com.br?subject=Problema%20Encontrado&body=";
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  static void launchUrl(String link) async {
    String _url = link;
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  static void launchMap(String latitude, String longitude) async {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  // static Market getClosestPositionMarket(List<Market> markets) async {
  //   Position position = await determinePosition();
  //   List<double> distances = markets.map((e) {
  //     return Geolocator.distanceBetween(
  //         position.latitude, position.longitude, e.latitude, e.longitude);
  //   }).toList();

  // }
}
