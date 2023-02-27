import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_app/email_auth/user.dart';

class RewardsController extends GetxController {
  Future<void> addReward(String ref) async {
    // assume that you have a Firestore instance and a reference to a collection
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('referCode', isEqualTo: ref)
        .get();

// update the 'age' field of the first document in the query results
    if (querySnapshot.docs.isNotEmpty) {
      UserS userS = UserS.fromMap(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
      if (userS.reward < 3) {
        DocumentReference documentReference = querySnapshot.docs[0].reference;
        int reward = userS.reward + 1;
        documentReference.update({
          'reward': reward,
        });
      }
    }
  }
}
