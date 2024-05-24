import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Controller/commentController.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Screens/TimeStamp.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:notify_ju/Screens/comments.dart';

class AdminViewComment extends StatefulWidget {
  final String post_id;

  const AdminViewComment({
    super.key,
    required this.post_id,
  });

  @override
  State<AdminViewComment> createState() => _AdminViewComment();
}

class _AdminViewComment extends State<AdminViewComment> {
  final controller1 = Get.put(commentController());
  final AuthenticationRepository _authRepo =
      Get.put(AuthenticationRepository());
  final controller2 = Get.put(AdminController());
  final TextEditingController textController = TextEditingController();
  final TextEditingController editTextController =
      TextEditingController(); // Separate controller for edit dialog

  @override
  void dispose() {
    textController.dispose();
    editTextController.dispose(); // Dispose of the edit dialog controller
    super.dispose();
  }

  void deleteCommentLocally(
      List<Map<String, dynamic>> comments, String commentId) {
    setState(() {
      comments.removeWhere((comment) => comment['comment_id'] == commentId);
    });
  }

  Future<void> deleteComment(String post_id, String commentId,
      List<Map<String, dynamic>> comments) async {
    try {
      deleteCommentLocally(
          comments, commentId); // Immediately remove the comment locally
      await controller2.deleteComment(
          post_id, commentId); // Proceed with server deletion
    } catch (error) {
      log('Error deleting comment: $error');
      // Optionally, show an error message and revert the local deletion
    }
  }

  void showDeleteConfirmationDialog(
      String commentId, List<Map<String, dynamic>> comments) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Comment'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog first
                await deleteComment(widget.post_id, commentId, comments);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text('Comments', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF464A5E),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream:
                    Stream.fromFuture(controller1.getComments(widget.post_id)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> comments = snapshot.data!;
                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        final commentEmail = comment['email'] ?? 'No email';
                        final commentId = comment['comment_id'] ?? 'No ID';

                        return Comments(
                          text:
                              comment['commentDescription'] ?? 'No description',
                          email: commentEmail,
                          time: formatData(comment['Timestamp']),
                          comment_id: commentId,
                          isOwner: true, // Admin can delete any comment
                          onDelete: () =>
                              showDeleteConfirmationDialog(commentId, comments),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: AdminNavigationBarWidget(),
    );
  }
}
