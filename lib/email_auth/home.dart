import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/email_auth/log_in_screen.dart';

class RewardHomeScreen extends StatefulWidget {
  const RewardHomeScreen({super.key});

  @override
  State<RewardHomeScreen> createState() => _RewardHomeScreenState();
}

class _RewardHomeScreenState extends State<RewardHomeScreen> {
  TextEditingController controller = TextEditingController();
  String past = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reward screen'),
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPaste(),
            Container(
              color: Colors.amber,
              height: 200,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> mapList =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return ListTile(
                              title: Text(
                                mapList['referLink'],
                              ),
                              subtitle: Text(
                                mapList['email'] ?? '',
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.content_copy),
                                onPressed: () async {
                                  await FlutterClipboard.copy(
                                      mapList['referLink']);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Copy Text'),
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                    } else {
                      return const Text('no data');
                    }
                  } else {
                    return const CircleAvatar();
                  }
                },
              ),
            ),
          ],
        ),
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
        return const LogInScreen();
      },
    ));
  }

  Widget buildPaste() => Row(
        children: [
          Expanded(child: Text(past)),
          IconButton(
            icon: const Icon(Icons.paste),
            onPressed: () async {
              final value = await FlutterClipboard.paste();

              setState(() {
                past = value;
              });
            },
          )
        ],
      );
}
