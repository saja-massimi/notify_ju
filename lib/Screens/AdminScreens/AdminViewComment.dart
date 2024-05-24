import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Controller/commentController.dart';
import 'package:notify_ju/Screens/PagesVote/TimeStamp.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';
import 'package:notify_ju/Screens/PagesVote/comments.dart';

class AdminViewComment extends StatefulWidget {
  final String post_id;

  const AdminViewComment({
    super.key,
    required this.post_id,
  });

  @override
  State<AdminViewComment> createState() => _AdminViewCommentState();
}

class _AdminViewCommentState extends State<AdminViewComment> {
  final controller1 = Get.put(commentController());
  final controller2 = Get.put(AdminController());
  final TextEditingController textController = TextEditingController();
  final TextEditingController editTextController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    editTextController.dispose();
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
      deleteCommentLocally(comments, commentId);
      await controller2.deleteComment(post_id, commentId);
    } catch (error) {
      log('Error deleting comment: $error');
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
                Navigator.of(context).pop();
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
                          isOwner: false,
                          onDelete: () =>
                              showDeleteConfirmationDialog(commentId, comments),
                          isAdmin: true,
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
