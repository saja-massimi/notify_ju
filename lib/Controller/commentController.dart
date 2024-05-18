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

  // Future<void> updateComment(String commentId, String newText) async {
  //   final docID = await getDocumentIdByEmail(auth?.email ?? "");
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(docID)
  //       .collection('comments')
  //       .doc(commentId)
  //       .update({'commentDescription': newText});
  // }

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

  // Future<void> deleteComment(String commentId) async {
  //   final docID = await getDocumentIdByEmail(auth?.email ?? "");

  //   await _db
  //       .collection('/users/$docID/comments')
  //       .doc(commentId)
  //       .delete()
  //       .then((value) => Get.snackbar("Success", "comment Deleted Succesfully"))
  //       .catchError((error) =>
  //           Get.snackbar("Error", "comment Deletion Failed: $error"));
  // }

  // Future<void> updateComment(String commentId, commentModel comment) async {
  //   final documentId = await getDocumentIdByEmail(auth?.email ?? "");

  //   await _db
  //       .collection('users/$documentId/comments')
  //       .doc(commentId)
  //       .update(comment.toJson())
  //       .then((value) => Get.snackbar("Success", "comment Updated Succesfully"))
  //       .catchError(
  //           (error) => Get.snackbar("Error", "comment Update Failed: $error"));
  // }

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
  // Future<List<Map<String, dynamic>>> getComments(post_id) async {
  //   try {
  //     QuerySnapshot usersSnapshot =
  //         await FirebaseFirestore.instance.collection('users').get();

  //     List<Map<String, dynamic>> allposts = [];

  //     for (var userDoc in usersSnapshot.docs) {
  //       QuerySnapshot reportsSnapshot =
  //           await userDoc.reference.collection('comments').get();

  //       allposts.addAll(reportsSnapshot.docs
  //           .map((doc) => doc.data() as Map<String, dynamic>));
  //     }
  //     return allposts;
  //   } catch (e) {
  //     log("Error fetching reports: $e");
  //     throw e;
  //   }
  // }

//   Future<void> deletePost(postModel model) async {
//     final docID = await getDocumentIdByEmail(auth?.email ?? "");

//     await _db
//         .collection('post')
//         .doc(model.post_id)
//         .delete()
//         .then((value) => Get.snackbar("Success", "post Deleted Succesfully"))
//         .catchError(
//             (error) => Get.snackbar("Error", "post Deletion Failed: $error"));
//   }

//   Future<List<Map<String, dynamic>>> getpost() async {
//     try {
//       QuerySnapshot usersSnapshot =
//           await FirebaseFirestore.instance.collection('post').get();

//       List<Map<String, dynamic>> allposts = [];

//       for (var userDoc in usersSnapshot.docs) {
//         QuerySnapshot reportsSnapshot =
//             await userDoc.reference.collection('post').get();

//         allposts.addAll(reportsSnapshot.docs
//             .map((doc) => doc.data() as Map<String, dynamic>));
//       }
//       return allposts;
//     } catch (e) {
//       log("Error fetching reports: $e");
//       throw e;
//     }
//   }

//   Future<void> likePost(postModel model) async {
//     try {
//       final docID = await getDocumentIdByEmail(model.email);
//       // Get a reference to the post document
//       DocumentReference postRef = FirebaseFirestore.instance
//           .collection('users')
//           .doc(docID)
//           .collection('post')
//           .doc(model.post_id);

//       // Update the likes field in the post document
//       await postRef.update({
//         'likesCount': FieldValue.arrayUnion([auth?.email ?? ""])
//       });
//       // await postRef.update({
//       //   'likesCount': FieldValue.arrayRemove([auth?.email ?? ""])
//       // });

//       print('Post liked successfully');
//     } catch (error) {
//       print('Error liking post: $error');
//     }
//   }

//   Future<void> addComment(postModel model, String comment) async {
//     try {
//       final docID = await getDocumentIdByEmail(auth?.email ?? "");
//       log(docID.toString());
//       if (docID != null) {
//         await _db
//             .collection('users')
//             .doc(docID)
//             .collection('post')
//             .doc(model.post_id)
//             .collection('comments')
//             .doc(model.comments)
//             .set(model.toJson());
//         Get.snackbar("Success", "Post sent successfully");
//       } else {
//         Get.snackbar("Error", "User not found");
//       }
//     } catch (error) {
//       Get.snackbar("Error", 'Failed to create post: $error');
//     }
//   }

//   // Future <voi> addComment(String postId , String text , String email) async {
//   //   try {
//   //           final docID = await getDocumentIdByEmail(email);

//   //     if(text.isNotEmpty){
//   //       String comment_id = Uuid().v1();
//   //        await FirebaseFirestore.instance.collection('users')
//   //         .doc(docID).
//   //         collection('post').
//   //         doc(postId).
//   //         collection('comments').
//   //         doc(comment_id).
//   //         set({
//   //           'comment_id': comment_id,
//   //           'comment': text,
//   //           'email': email,
//   //           'time': DateTime.now(),
//   //         });

//   // }
//   //   } catch (error) {
//   //     print('Error commenting post: $error');
//   //   }
//   // }

//   Future<void> dislike(postModel model) async {
//     try {
//       final docID = await getDocumentIdByEmail(auth?.email ?? "");
//       // Get a reference to the post document
//       DocumentReference postRef = FirebaseFirestore.instance
//           .collection('users')
//           .doc(docID)
//           .collection('post')
//           .doc(model.post_id);

//       print('comments added successfully');
//     } catch (error) {
//       print('Error commenting post: $error');
//     }
//   }
// }
}
