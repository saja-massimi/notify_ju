import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:notify_ju/Controller/ReportsController.dart';
import 'package:notify_ju/Models/postModel.dart';
import 'package:notify_ju/Screens/AdminScreens/AdminIncident.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final User? auth = FirebaseAuth.instance.currentUser!;

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

  Future<void> addPost(postModel model) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      await _db
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(model.post_id)
          .set(model.toJson());
    } catch (e) {
      log("Error adding post: $e");
      throw e;
    }
  }

  Future<void> deletePost(postModel model) async {
    final docID = await getDocumentIdByEmail(auth?.email ?? "");

    await _db
        .collection('/users/$docID/post')
        .doc(model.post_id)
        .delete()
        .then((value) => Get.snackbar("Success", "post Deleted Succesfully"))
        .catchError(
            (error) => Get.snackbar("Error", "post Deletion Failed: $error"));
  }

  Future<List<Map<String, dynamic>>> getpost() async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      final snapshot =
          await _db.collection('users').doc(docID).collection('post').get();
      final List<Map<String, dynamic>> posts =
          snapshot.docs.map((doc) => doc.data()).toList();
      return posts;
    } catch (e) {
      log("Error getting post: $e");
      throw e;
    }
  }
}
