// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class FirebaseStorageWidget extends StatefulWidget {
//   const FirebaseStorageWidget({super.key});

//   @override
//   State<FirebaseStorageWidget> createState() => _FirebaseStorageWidgetState();
// }

// class _FirebaseStorageWidgetState extends State<FirebaseStorageWidget> {
//   late TextEditingController nameController;
//   late TextEditingController emailController;
//   File? imageFile;

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController();
//     emailController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     nameController.dispose();
//     emailController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(children: [
//           InkWell(
//             onTap: () async {
//               XFile? imagePicker =
//                   await ImagePicker().pickImage(source: ImageSource.gallery);
//               if (imagePicker != null) {
//                 imageFile = File(imagePicker.path);
//                 setState(() {});
//                 log('Pick Image');
//               } else {
//                 log('no Image');
//               }
//             },
//             child: CircleAvatar(
//               radius: 30.0,
//               backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
//             ),
//           ),
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(hintText: 'name'),
//           ),
//           TextField(
//             controller: emailController,
//             decoration: const InputDecoration(hintText: 'email'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               addData();
//             },
//             child: const Text('Add'),
//           ),
//           Expanded(
//             child: getData(),
//           ),
//         ]),
//       ),
//     );
//   }

//   addData() async {
//     String name = nameController.text.trim();
//     String email = emailController.text.trim();
//     nameController.clear();
//     emailController.clear();

//     if (name.isNotEmpty && email.isNotEmpty && imageFile != null) {
//       UploadTask uploadTask = FirebaseStorage.instance
//           .ref()
//           .child('Profile Image')
//           .child('FileImage')
//           .putFile(imageFile!);

//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();

//       Map<String, dynamic> mapList = {
//         'name': name,
//         'email': email,
//         'picImage': downloadUrl,
//       };

//       FirebaseFirestore.instance.collection('user').add(mapList);
//       log('add data');
//     } else {
//       log('fill all the field');
//     }
//     setState(() {
//       imageFile = null;
//     });
//   }

//   Widget getData() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('user').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           if (snapshot.hasData && snapshot.data != null) {
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 Map<String, dynamic> mapList =
//                     snapshot.data!.docs[index].data() as Map<String, dynamic>;
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(mapList['picImage']),
//                   ),
//                   title: Text(mapList['name']),
//                   subtitle: Text(mapList['email']),
//                   trailing: IconButton(
//                       onPressed: () {
//                         snapshot.data!.docs[index].reference.delete();
//                       },
//                       icon: const Icon(Icons.delete)),
//                 );
//               },
//             );
//           } else {
//             return const Text('No data');
//           }
//         } else {
//           return const CircularProgressIndicator(
//             strokeWidth: 2.0,
//           );
//         }
//       },s
//     );
//   }
// }
