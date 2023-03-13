import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              child: const Text('Forgot'),
              onPressed: () async {
                String forgotPassword = emailController.text.trim();
                try {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: forgotPassword);
                  log('reset password');
                } on FirebaseAuthException catch (e) {
                  log(e.code.toString());
                }
                // auth
                //     .sendPasswordResetEmail(email: forgotPassword)
                //     .then((value) {
                //   log('We have sent you email to recover password, please check email');
                // }).onError((error, stackTrace) {
                //   log(error.toString());
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}
