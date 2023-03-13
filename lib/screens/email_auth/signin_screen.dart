import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/screens/email_auth/home.dart';

import 'forgot_password.dart';

class SigninScreenUs extends StatefulWidget {
  const SigninScreenUs({super.key});

  @override
  State<SigninScreenUs> createState() => _SigninScreenUsState();
}

class _SigninScreenUsState extends State<SigninScreenUs> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            signIn();
          },
          child: const Text('Sign in'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen()));
            log('forgot');
          },
          child: const Text('forgot password'),
        ),
      ]),
    );
  }

  void signIn() async {
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
                return const Homescreen();
              },
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        print(e.code.toString());
      }
    }
  }
}
