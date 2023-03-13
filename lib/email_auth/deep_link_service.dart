// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DepLinkService {
  DepLinkService._();
  static DepLinkService? _instance;

  static DepLinkService? get instance {
    _instance ??= DepLinkService._();
    return _instance;
  }

  // ValueNotifier<String> referrerCode = ValueNotifier<String>('');
  final dynamicLink = FirebaseDynamicLinks.instance;

  Future<String> createReferLink(String referCode) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://usamadev1.page.link',
      link: Uri.parse('https://chatapp.com/refer.code/refer?code=$referCode'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.new_app',
        minimumVersion: 1,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'REFER A FRIEND & EARN',
        description: 'Earn 1,000USD on every referral',
        imageUrl: Uri.parse(
            'https://moru.com.np/wp-content/uploads/2021/03/Blog_refer-Earn.jpg'),
      ),
    );

    final shortLink = await dynamicLink.buildShortLink(dynamicLinkParameters);

    return shortLink.shortUrl.toString();
  }
}
