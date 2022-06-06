import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:uni_links/uni_links.dart' as uni_links;

class AppLinkHelper {
  AppLinkHelper._();

  static final _singleton = AppLinkHelper._();
  static AppLinkHelper get instance => _singleton;

  Future<void> receiveInitialLink() async {
    /// Dynamic Links
    final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    print('dynamic link: ${initialLink?.link}');

    /// Deep Links or App Link
    try {
      final initialUniLink = await uni_links.getInitialLink();
      print('uni link: $initialUniLink');
    } catch (e) {
      // ...
    }
  }

  void initListener() async {
    /// Dynamic Links
    FirebaseDynamicLinks.instance.onLink.listen((data) {
      print('dynamic link: ${data.link}');
    });

    /// Deep Links or App Link
    uni_links.uriLinkStream.listen((link) {
      if (link == null) {
        return;
      }
      print('uni link from listener: $link');
    });
  }
}