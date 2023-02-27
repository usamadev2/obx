import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/email_auth/home.dart';
import 'package:new_app/email_auth/sign_up_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: 'email '),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: 'Password '),
          ),
          ElevatedButton(
            onPressed: () {
              logIn();
            },
            child: const Text('log in'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
            child: const Text('Sign up'),
          ),
        ]),
      ),
    );
  }

  void logIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
      print('fill all the field');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          if (!mounted) return;
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const RewardHomeScreen();
              },
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        log(e.code.toString());
      }
    }
  }
}
