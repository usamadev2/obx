import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:new_app/firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  String data = await handleDeeplink();
  FirebaseDynamicLinks.instance.onLink.listen((event) {
    print(event.link);
  }).onError((v) {
    debugPrint('Failed: $v');
  });

  runApp(MyApp(text: data));
}

Future<String> handleDeeplink() async {
  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    // Example of using the dynamic link to push the user to a different screen
    // Navigator.pushNamed(context, deepLink.path);
    return deepLink.toString();
  } else {
    return 'nothing';
  }
}

class MyApp extends StatelessWidget {
  final String text;

  const MyApp({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(text),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final dynamicLinkParams = DynamicLinkParameters(
              link: Uri.parse("https://www.solomon.com/${_generateRef()}"),
              uriPrefix: "https://usamadev1.page.link/",
              androidParameters:
                  const AndroidParameters(packageName: "com.example.new_app"),
              iosParameters:
                  const IOSParameters(bundleId: "com.example.new_app"),
            );
            final dynamicLink = await FirebaseDynamicLinks.instance
                .buildLink(dynamicLinkParams);
            print('=======>$dynamicLink');
          },
        ),
      ),
    );
  }

  String _generateRef() {
    Random random = Random();
    var id = random.nextInt(92143543) + 09451234356;
    return 'ref-${id.toString().substring(0, 8)}';
  }
}











// import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../firebase_options.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // iOS requires you run in release mode to test dynamic links ("flutter run --release").
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(
//     MaterialApp(
//       title: 'Dynamic Links Example',
//       routes: <String, WidgetBuilder>{
//         '/': (BuildContext context) => _MainScreen(),
//         '/helloworld': (BuildContext context) => _DynamicLinkScreen(),
//       },
//     ),
//   );
// }

// class _MainScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<_MainScreen> {
//   String? _linkMessage;
//   bool _isCreatingLink = false;

//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//   final String _testString =
//       'To test: long press link and then copy and click from a non-browser '
//       "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
//       'is properly setup. Look at firebase_dynamic_links/README.md for more '
//       'details.';

//   final String DynamicLink = 'https://example/helloworld';
//   final String Link = 'https://flutterfiretests.page.link/MEGs';

//   @override
//   void initState() {
//     super.initState();
//     initDynamicLinks();
//   }

//   Future<void> initDynamicLinks() async {
//     dynamicLinks.onLink.listen((dynamicLinkData) {
//       Navigator.pushNamed(context, dynamicLinkData.link.path);
//     }).onError((error) {
//       print('onLink error');
//       print(error.message);
//     });
//   }

//   Future<void> _createDynamicLink(bool short) async {
//     setState(() {
//       _isCreatingLink = true;
//     });

//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://usamadev1.page.link',
//       link: Uri.parse(
//         'https://chatapp.com/refer.code/refer?code=ref-12345',
//       ),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.example.new_app',
//         minimumVersion: 0,
//       ),
//     );

//     Uri url;
//     if (short) {
//       final ShortDynamicLink shortLink =
//           await dynamicLinks.buildShortLink(parameters);
//       url = shortLink.shortUrl;
//     } else {
//       url = await dynamicLinks.buildLink(parameters);
//     }

//     setState(() {
//       _linkMessage = url.toString();
//       _isCreatingLink = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Dynamic Links Example'),
//         ),
//         body: Builder(
//           builder: (BuildContext context) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   ButtonBar(
//                     alignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       ElevatedButton(
//                         onPressed: () async {
//                           final PendingDynamicLinkData? data =
//                               await dynamicLinks.getInitialLink();
//                           final Uri? deepLink = data?.link;

//                           if (deepLink != null) {
//                             // ignore: unawaited_futures
//                             Navigator.pushNamed(context, deepLink.path);
//                           }
//                         },
//                         child: const Text('getInitialLink'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () async {
//                           final PendingDynamicLinkData? data =
//                               await dynamicLinks
//                                   .getDynamicLink(Uri.parse(Link));
//                           final Uri? deepLink = data?.link;

//                           if (deepLink != null) {
//                             // ignore: unawaited_futures
//                             Navigator.pushNamed(context, deepLink.path);
//                           }
//                         },
//                         child: const Text('getDynamicLink'),
//                       ),
//                       ElevatedButton(
//                         onPressed: !_isCreatingLink
//                             ? () => _createDynamicLink(false)
//                             : null,
//                         child: const Text('Get Long Link'),
//                       ),
//                       ElevatedButton(
//                         onPressed: !_isCreatingLink
//                             ? () => _createDynamicLink(true)
//                             : null,
//                         child: const Text('Get Short Link'),
//                       ),
//                     ],
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       if (_linkMessage != null) {
//                         await launchUrl(Uri.parse(_linkMessage!));
//                       }
//                     },
//                     onLongPress: () {
//                       Clipboard.setData(ClipboardData(text: _linkMessage));
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Copied Link!')),
//                       );
//                     },
//                     child: Text(
//                       _linkMessage ?? '',
//                       style: const TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                   Text(_linkMessage == null ? '' : _testString)
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class _DynamicLinkScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Hello World DeepLink'),
//         ),
//         body: const Center(
//           child: Text('Hello, World!'),
//         ),
//       ),
//     );
//   }
// }











// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:new_app/New%20folder/repositories/user_repository.dart';
// import 'package:new_app/New%20folder/services/deep_link_service.dart';
// import 'package:new_app/New%20folder/view/reward/reward.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   DeepLinkService.instance?.handleDynamicLinks();

//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     UserRepository.instance.listenToCurrentAuth();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Reward App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const RewardWidget(),
//     );
//   }
// }
