import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicLinkController extends GetxController {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  String? ref;
  String name = 'usama';

  Future<void> handleDynamicLinks() async {
    name += '1,';
    //Get initial dynamic link if app is started using the link
    final data = await dynamicLinks.getInitialLink();
    name += '2,';
    if (data != null) {
      name += '3,';
      await _handleDeepLink(data);
      name += '4,';
    }

    //handle foreground
    dynamicLinks.onLink.listen((event) {
      _handleDeepLink(event);
    }).onError((v) {
      debugPrint('Failed: $v');
    });
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData data) async {
    name += '5,';
    final Uri deepLink = data.link;
    name += '6,';
    log(deepLink.toString());
    name += '7,';
    var isRefer = deepLink.pathSegments.contains('refer');
    name += '8,';
    log(isRefer.toString());
    name += '9,';
    if (isRefer) {
      name += '10,';
      var code = deepLink.queryParameters['code'];
      name += '11,';
      ref = code;
      name += '12,';

      name = 'mateen';
      name += '13,';
      if (code != null) {
        code;

        log(code.toString());
        update();
      }
    }
  }
}
