import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Models/warningModel.dart';

class WarningsController extends GetxController {


  @override
  void onInit() {
    super.onInit();
  }
  final _db = FirebaseFirestore.instance;

  Future<String?> getDocumentIdByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('user_email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } catch (error) {
      log('Error getting document ID by email: $error');
      return null;
    }
  }

  Future <void> createWarning(WarningModel warning) async{
try {

    final documentId = await getDocumentIdByEmail(warning.subAdminEmail);
    if (documentId != null) {
      await _db
          .collection('users')
          .doc(documentId)
          .collection('warnings')
          .doc(warning.id)
          .set(warning.toJson());
          
      log( " Warning sent successfully");
    } else {
      log( "User not found");
    }
  } catch (error) {
      log( 'Failed to create warning: $error');
  }


}

// Future<List<Map<String, dynamic>>?> getAllWarnings() async{ 



// }

}