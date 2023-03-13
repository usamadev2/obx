import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/screens/email_auth/signin_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Firebase'),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.popUntil(
      context,
      (route) {
        return route.isFirst;
      },
    );
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const SigninScreenUs();
      },
    ));
  }
}
