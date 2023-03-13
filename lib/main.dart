import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/firebase_options.dart';

import 'controllers/dynamic_link_controller.dart';
import 'controllers/rewards_controller.dart';
import 'email_auth/home.dart';
import 'email_auth/sign_up_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put<DynamicLinkController>(DynamicLinkController()).handleDynamicLinks();
  Get.put(RewardsController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? const SignUpScreen()
          : const RewardHomeScreen(),
    );
  }
}








//   /// get
//   // QuerySnapshot snapshot =
//   //     await FirebaseFirestore.instance.collection('user').get();
//   // for (var doc in snapshot.docs) {
//   //   log(doc.data().toString());
//   // }

//   // Map<String, dynamic> mapList = {
//   //   'email': 'usamadev2@gmail.com',
//   //   'name': 'usamadev2'
//   // };

//   /// set
//   // FirebaseFirestore.instance.collection('user').doc().set(mapList);
//   // log('data add');

//   /// update
//   // await FirebaseFirestore.instance
//   //     .collection('user')
//   //     .doc('33QLO22DkH90gWcLUF6H')
//   //     .update({'email': 'awais@gmail'});
//   // log('data update');

//   // FirebaseFirestore.instance
//   //     .collection('user')
//   //     .doc('33QLO22DkH90gWcLUF6H')
//   //     .delete();
//   // log('delete');