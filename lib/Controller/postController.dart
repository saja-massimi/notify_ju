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
      Get.snackbar("Success", "post deleted successfully");
    } catch (error) {
      Get.snackbar("Error", "Failed to delete post: $error");
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

  Future<List<Map<String, dynamic>>> getPost() async {
    try {
      // Fetch all posts from all users, ordering by likesCount in descending order
      QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
          .collectionGroup(
              'post') // Using collectionGroup to fetch all subcollection posts
          .orderBy('likesCount', descending: true)
          .get();

      // Convert the documents to a list of maps
      List<Map<String, dynamic>> allPosts = postsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return allPosts;
    } catch (e) {
      log("Error fetching posts: $e");
      throw e;
    }
  }

  Future<void> likePost(postModel model, String email) async {
    try {
      final docID = await getDocumentIdByEmail(model.email);
      if (docID == null) {
        print('Document ID not found for email: ${model.email}');
        return;
      }
      DocumentReference postRef = _db
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(model.post_id);

      await postRef.update({
        'likesCount': FieldValue.arrayUnion([email])
      });
      print('Post liked successfully');
    } catch (error) {
      print('Error liking post: $error');
    }
  }

  Future<void> dislike(postModel model, String email) async {
    try {
      final docID = await getDocumentIdByEmail(model.email);
      if (docID == null) {
        print('Document ID not found for email: ${model.email}');
        return;
      }
      DocumentReference postRef = _db
          .collection('users')
          .doc(docID)
          .collection('post')
          .doc(model.post_id);

      await postRef.update({
        'likesCount': FieldValue.arrayRemove([email])
      });
      print('Post disliked successfully');
    } catch (error) {
      print('Error disliking post: $error');
    }
  }

  Future<List<Map<String, dynamic>>?> viewAllUserPosts() async {
    final documentId = await getDocumentIdByEmail(auth?.email ?? "");

    try {
      final snapshot = await _db.collection('/users/$documentId/post').get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log("Error fetching user posts: $e");
      return null;
    }
  }
}
