import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: numberController,
          decoration: const InputDecoration(hintText: 'Phone Number'),
        ),
        ElevatedButton(
          onPressed: () {
            phoneAuth();
          },
          child: const Text('click'),
        ),
        ElevatedButton(
          onPressed: () {
            _showbottomSheat();
          },
          child: const Text('show modal bottom sheat'),
        ),
      ],
    ));
  }

  void phoneAuth() {
    if (numberController.text.isNotEmpty) {
      String number = numberController.text.trim();

      FirebaseAuth.instance.verifyPhoneNumber(
        codeSent: (verificationId, _) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OtpScreen(
                  verificationId: verificationId,
                );
              },
            ),
          );
        },
        phoneNumber: number,
        verificationCompleted: (_) {},
        verificationFailed: (Error) {
          log(Error.code.toString());
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    }
  }

  _showbottomSheat() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 200.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            color: Colors.amber,
          ),
        );
      },
    );
  }
}
