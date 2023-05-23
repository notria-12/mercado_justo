import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_plus/share_plus.dart';

import '../auth/auth_controller.dart';

class DynamicLinkProvider {
  Future<String> createLink(String inviteId) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link:
          Uri.parse("https://mercado-justo-bc5a8.web.app/?inviteId=$inviteId"),
      uriPrefix: "https://mercadojusto.page.link",
      androidParameters:
          const AndroidParameters(packageName: "br.com.mercadojusto"),
      iosParameters: const IOSParameters(bundleId: "br.com.mercadojusto"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return dynamicLink.shortUrl.toString();
  }

  void initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;

      Share.share("Link: ${refLink.data}");
    }
  }
}
