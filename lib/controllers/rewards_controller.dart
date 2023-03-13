import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_app/email_auth/user.dart';

class RewardsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addReward(String ref) async {
    // getting parent user ref
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('referCode', isEqualTo: ref)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      UserS userS = UserS.fromMap(
        querySnapshot.docs.first.data() as Map<String, dynamic>,
      );
      DocumentReference documentReference = querySnapshot.docs[0].reference;
      int reward = userS.reward + 20;
      documentReference.update(
        {
          'reward': reward,
        },
      );

      // for next user (5 $)
      final secondParentQuerySnapshot = await firestore
          .collection('users')
          .where('referCode', isEqualTo: userS.referralCode)
          .get();
      if (secondParentQuerySnapshot.docs.isNotEmpty) {
        UserS userS = UserS.fromMap(
          secondParentQuerySnapshot.docs.first.data(),
        );
        DocumentReference documentReference =
            secondParentQuerySnapshot.docs[0].reference;
        int reward = userS.reward + 5;
        documentReference.update(
          {
            'reward': reward,
          },
        );

        // for next user (3 $)
        final thirdParentQuerySnapshot = await firestore
            .collection('users')
            .where('referCode', isEqualTo: userS.referralCode)
            .get();
        if (thirdParentQuerySnapshot.docs.isNotEmpty) {
          UserS userS = UserS.fromMap(
            thirdParentQuerySnapshot.docs.first.data(),
          );
          DocumentReference documentReference =
              thirdParentQuerySnapshot.docs[0].reference;
          int reward = userS.reward + 3;
          documentReference.update(
            {
              'reward': reward,
            },
          );
          // for next user (2 $)
          final fourParentQuerySnapshot = await firestore
              .collection('users')
              .where('referCode', isEqualTo: userS.referralCode)
              .get();
          if (fourParentQuerySnapshot.docs.isNotEmpty) {
            UserS userS = UserS.fromMap(
              fourParentQuerySnapshot.docs.first.data(),
            );
            DocumentReference documentReference =
                fourParentQuerySnapshot.docs[0].reference;
            int reward = userS.reward + 2;
            documentReference.update(
              {
                'reward': reward,
              },
            );
          }
        }
      }
    }
  }

  // getUserAndAddReward(String userId ,int reward )async{
  //   QuerySnapshot querySnapshot = await firestore
  //       .collection('users')
  //       .where('referCode', isEqualTo: parentRef)
  //       .get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     UserS userS = UserS.fromMap(
  //         querySnapshot.docs.first.data() as Map<String, dynamic>);
  //     DocumentReference documentReference = querySnapshot.docs[0].reference;
  //     int reward = userS.reward + 20;
  //     documentReference.update(
  //       {
  //         'reward': reward,
  //       },
  //     );
  //   }
  // }
}
