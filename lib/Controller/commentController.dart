import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Models/commentModel.dart';

class commentController extends GetxController {
  static commentController get instance => Get.find();
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

  Future<void> addacomment(commentModel model) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      log(docID.toString());
      if (docID != null) {
        await _db
            .collection('users')
            .doc(docID)
            .collection('post')
            .doc(model.post_id)
            .collection('comments')
            .doc(model.comment_id)
            .set(model.toJson());
        Get.snackbar("Success", "comment sent successfully");
      } else {
        Get.snackbar("Error", "User not found");
      }
    } catch (error) {
      Get.snackbar("Error", 'Failed to create comment: $error');
    }
  }

  Future<void> updateComment(
      String postId, String commentId, String newText) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      await _db
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .update({'commentDescription': newText});
      Get.snackbar("Success", "Comment updated successfully");
    } catch (error) {
      Get.snackbar("Error", "Failed to update comment: $error");
    }
  }

  Future<void> deleteComment(String postId, String commentId) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      await _db
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .delete();
      Get.snackbar("Success", "Comment deleted successfully");
    } catch (error) {
      Get.snackbar("Error", "Failed to delete comment: $error");
    }
  }

  Future<List<Map<String, dynamic>>> getComments(String post_id) async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> allComments = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot commentsSnapshot = await userDoc.reference
            .collection('post')
            .doc(post_id)
            .collection('comments')
            .get();

        allComments.addAll(commentsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
      }
      return allComments;
    } catch (e) {
      log("Error fetching comments: $e");
      throw e;
    }
  }
}
