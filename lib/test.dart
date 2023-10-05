import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamiclinkService {
  static final DynamiclinkService _singleton = DynamiclinkService._internal();

  DynamiclinkService._internal();

  static DynamiclinkService get instance => _singleton;

  Future<ShortDynamicLink> createDynamicLink(String text) async {
    final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse('https://gstest1.page.link/share?text=$text'),
        uriPrefix: 'https://gstest1.page.link',
        androidParameters:
        const AndroidParameters(packageName: 'com.example.deeplink'),
        iosParameters: const IOSParameters(bundleId: 'com.example.deeplink'));

    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    print('${dynamicLink.shortUrl}');
    return dynamicLink;
  }
}
