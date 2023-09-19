import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/shared/utils/error.dart';
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
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        throw Failure(
            message: 'Serviços de localização estão desabilitados',
            title: 'Localização');
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
          throw Failure(
              title: 'Localização',
              message: 'Permissão para localização foi negada!');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        throw Failure(
            title: 'Localização',
            message: 'Permissão para localização foi permanentemente negada!');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      throw Failure(
          message: 'Erro desconhecido ao buscar localização',
          title: 'Localização');
    }
  }
}
