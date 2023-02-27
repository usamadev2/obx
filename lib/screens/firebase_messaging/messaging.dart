// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../email_auth/login_screen.dart';
// import '../phone/phone_screen.dart';

// class NotificationMessage extends StatefulWidget {
//   const NotificationMessage({super.key});

//   @override
//   State<NotificationMessage> createState() => _NotificationMessageState();
// }

// class _NotificationMessageState extends State<NotificationMessage> {
//   void getInitialMessage() async {
//     RemoteMessage? message =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (message != null) {
//       if (message.data["page"] == "email") {
//         if (!mounted) return;

//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const SignUpScreen()));
//       } else if (message.data["page"] == "phone") {
//         if (!mounted) return;

//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const PhoneScreen()));
//       } else {
//         if (!mounted) return;

//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Invalid Page!"),
//           duration: Duration(seconds: 5),
//           backgroundColor: Colors.red,
//         ));
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     getInitialMessage();

//     FirebaseMessaging.onMessage.listen((message) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(message.data["myname"].toString()),
//         duration: const Duration(seconds: 10),
//         backgroundColor: Colors.green,
//       ));
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("App was opened by a notification"),
//         duration: Duration(seconds: 10),
//         backgroundColor: Colors.green,
//       ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Message Notification'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//               onPressed: () async {
//                 const url = 'https://twitter.com/?lang=en';
//                 if (await canLaunchUrl(Uri.parse(url))) {
//                   await launchUrl(Uri.parse(url));
//                 }
//               },
//               child: const Text('open url in browser')),
//         ],
//       ),
//     );
//   }
// }
