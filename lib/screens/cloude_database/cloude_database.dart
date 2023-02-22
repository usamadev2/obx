import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudeFirebase extends StatefulWidget {
  const CloudeFirebase({super.key});

  @override
  State<CloudeFirebase> createState() => _CloudeFirebaseState();
}

class _CloudeFirebaseState extends State<CloudeFirebase> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () async {
              XFile? pickImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickImage != null) {
                imageFile = File(pickImage.path);
                setState(() {});
                log('pick image');
              } else {
                log('image not pick');
              }
            },
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
            ),
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'name'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: 'email'),
          ),
          ElevatedButton(
            onPressed: () {
              add();
            },
            child: const Text('click'),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: streamWidget(),
          ),
        ],
      ),
    );
  }

  add() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    nameController.clear();
    emailController.clear();

    if (name != '' && email != '' && imageFile != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('profileImage')
          .child('newImage')
          .putFile(imageFile!);

      TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> mapList = {
        'name': name,
        'email': email,
        'profileImage': downloadUrl,
      };
      FirebaseFirestore.instance.collection('user').add(mapList);
      log('user created');
    } else {
      log('fill all the field');
    }
    setState(() {
      imageFile = null;
    });
  }

  Widget streamWidget() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> mapList = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(mapList['profileImage']),
                      ),
                      title: Text(
                        mapList['name'],
                      ),
                      subtitle: Text(
                        mapList['email'],
                      ),
                      trailing: IconButton(
                          onPressed: () =>
                              snapshot.data!.docs[index].reference.delete(),
                          icon: const Icon(Icons.delete)),
                    );
                  });
            } else {
              return const Text('no data');
            }
          } else {
            return const CircleAvatar();
          }
        });
  }
}
