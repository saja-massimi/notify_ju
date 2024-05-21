// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Models/postModel.dart';

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
      log(docID.toString());
      if (docID != null) {
        await _db
            .collection('users')
            .doc(docID)
            .collection('post')
            .doc(model.post_id)
            .set(model.toJson());
        Get.snackbar("Success", "Post sent successfully");
      } else {
        Get.snackbar("Error", "User not found");
      }
    } catch (error) {
      Get.snackbar("Error", 'Failed to create post: $error');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      await _db
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(postId)
          .delete();
      Get.snackbar("Success", "Comment deleted successfully");
    } catch (error) {
      Get.snackbar("Error", "Failed to delete comment: $error");
    }
  }

  Future<void> updatePost(String postId, String newText) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      await _db
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(postId)
          .update({'description': newText});
      Get.snackbar("Success", "post updated successfully");
    } catch (error) {
      Get.snackbar("Error", "Failed to update post: $error");
    }
  }

  Future<List<Map<String, dynamic>>> getpost() async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> allposts = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot =
            await userDoc.reference.collection('post').get();

        allposts.addAll(reportsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>));
      }
      return allposts;
    } catch (e) {
      log("Error fetching reports: $e");
      throw e;
    }
  }

  Future<void> likePost(postModel model) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      DocumentReference postRef = FirebaseFirestore.instance
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(model.post_id);

      await postRef.update({
        'likesCount': FieldValue.arrayUnion([auth?.email ?? ""])
      });
      print('Post liked successfully');
    } catch (error) {
      print('Error liking post: $error');
    }
  }

  Future<void> dislike(postModel model) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      // Get a reference to the post document
      DocumentReference postRef = FirebaseFirestore.instance
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(model.post_id);

      // Update the likes field in the post document
      await postRef.update({
        'likesCount': FieldValue.arrayRemove([auth?.email ?? ""])
      });

      print('Post disliked successfully');
    } catch (error) {
      print('Error disliking post: $error');
    }
  }

  Future<void> commentPost(postModel model, String comment) async {
    try {
      final docID = await getDocumentIdByEmail(auth?.email ?? "");
      // Get a reference to the post document
      DocumentReference postRef = FirebaseFirestore.instance
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(model.post_id);

      log('comments added successfully');
    } catch (error) {
      log('Error commenting post: $error');
    }
  }

  Future<List<Map<String, dynamic>>?> viewAllUserPosts() async {
    final documentId = await getDocumentIdByEmail(auth?.email ?? "");

    try {
      final snapshot = await _db
          .collection('/users/$documentId/post') // Adjust collection path
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log("Error fetching user posts: $e");
      return null;
    }
  }
}
