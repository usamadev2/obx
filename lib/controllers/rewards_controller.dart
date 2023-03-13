import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_app/email_auth/user.dart';

class RewardsController extends GetxController {
  Future<void> addReward(String ref) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('referCode', isEqualTo: ref)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      UserS userS = UserS.fromMap(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
      DocumentReference documentReference = querySnapshot.docs[0].reference;
      int reward = userS.reward + 20;
      documentReference.update(
        {
          'reward': reward,
        },
      );
    }
  }
}
