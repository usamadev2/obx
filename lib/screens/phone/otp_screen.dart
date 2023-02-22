import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/screens/email_auth/home.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  verifyOTP() async {
    String otp = _phoneController.text.trim();

    final PhoneAuthCredential credentials = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);

      if (userCredential.user != null) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Homescreen(),
          ),
        );
      } else {
        log('user not created');
      }
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
            controller: _phoneController,
            decoration: const InputDecoration(hintText: 'number')),
        ElevatedButton(
            onPressed: () {
              verifyOTP();
            },
            child: const Text('send otp'))
      ]),
    );
  }
}
