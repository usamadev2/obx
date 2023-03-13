import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controllers/rewards_controller.dart';
import 'package:new_app/email_auth/user.dart';

import '../New folder/services/code_generator.dart';
import '../controllers/dynamic_link_controller.dart';
import 'deep_link_service.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  DynamicLinkController controller = Get.find<DynamicLinkController>();

  @override
  Widget build(BuildContext context) {
    referralCodeController.text = CodeGenerator.generateCode('ws');
    return GetBuilder<DynamicLinkController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign up'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.ref ?? 'null'),
                    Text(controller.name),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: 'Email '),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: 'Password '),
                    ),
                    TextField(
                      controller: referralCodeController,
                      decoration: const InputDecoration(hintText: 'hintText'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      child: const Text('Sign in'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LogInScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('log'),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  void signUp() async {
    UserCredential? credential;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String referCode = referralCodeController.text.trim();

    final referLink = await DepLinkService.instance?.createReferLink(referCode);

    if (email == '' || password == '' || referCode == '') {
      log('fill all the field');
    } else {
      try {
        credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        log('create account');
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
    if (credential != null) {
      if (Get.find<DynamicLinkController>().ref != null) {
        await Get.find<RewardsController>()
            .addReward(Get.find<DynamicLinkController>().ref!);
      }

      log('data add');
      String uid = credential.user!.uid;
      UserS userS = UserS(
        listRef: [controller.ref, referCode],
        uid: uid,
        email: email,
        parentUid: null,
        name: '',
        referCode: referCode,
        referLink: referLink!,
        referralCode: '${controller.ref}',
        reward: 0,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(userS.toMap());
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LogInScreen();
          },
        ),
      );
    }
  }
}
