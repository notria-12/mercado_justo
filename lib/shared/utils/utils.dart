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
}
