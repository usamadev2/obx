import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/screens/email_auth/signin_screen.dart';

class SignUpScreenUs extends StatefulWidget {
  const SignUpScreenUs({super.key});

  @override
  State<SignUpScreenUs> createState() => _SignUpScreenUsState();
}

class _SignUpScreenUsState extends State<SignUpScreenUs> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
        TextField(
          controller: conPasswordController,
          decoration: const InputDecoration(hintText: 'ConPassword '),
        ),
        ElevatedButton(
          onPressed: () {
            signUp();
          },
          child: const Text('Sign in'),
        ),
      ]),
    );
  }

  signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String conPassword = conPasswordController.text.trim();

    if (email == '' || password == '' || conPassword == '') {
      print('fill all the field');
    } else if (password != conPassword) {
      print('wrong password');
    } else {
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (credential.user != null) {
          if (!mounted) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SigninScreenUs();
              },
            ),
          );
        }
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
      }
    }
  }
}
