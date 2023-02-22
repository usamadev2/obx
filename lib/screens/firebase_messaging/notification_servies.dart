import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backGroundHandler(RemoteMessage message) async {
  log('receive message ${message.notification!.title}');
}

class NotificationServices {
  static Future<void> initialize() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      /// 2
      // FirebaseMessaging.onBackgroundMessage(backGroundHandler);
      // FirebaseMessaging.onMessage.listen((message) {
      //   log('receive message ${message.notification!.title}');
      // });
      /// complete 2
      ///
      log('Notification initialize');
    }
  }
}
