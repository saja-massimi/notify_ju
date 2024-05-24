import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/commentController.dart';
import 'package:notify_ju/Models/commentModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Screens/PagesVote/TimeStamp.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:random_string/random_string.dart';
import 'package:notify_ju/Screens/PagesVote/comments.dart';

class CommentCard extends StatefulWidget {
  final String post_id;

  const CommentCard({
    super.key,
    required this.post_id,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final controller1 = Get.put(commentController());
  final AuthenticationRepository _authRepo =
      Get.put(AuthenticationRepository());
  final TextEditingController textController = TextEditingController();
  final TextEditingController editTextController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    editTextController.dispose();
    super.dispose();
  }

  Future<void> editComment(
      String post_id, String commentId, String newText) async {
    if (newText.isNotEmpty) {
      await controller1.updateComment(post_id, commentId, newText);
      setState(() {});
    } else {
      log('Edit text is empty');
    }
  }

  Future<void> deleteComment(String post_id, String commentId) async {
    await controller1.deleteComment(post_id, commentId);
    setState(() {});
  }

  void showEditDialog(String commentId, String currentText) {
    editTextController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Comment'),
          content: TextField(
            controller: editTextController,
            decoration: const InputDecoration(hintText: 'Edit your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final newText = editTextController.text;
                if (newText.isNotEmpty) {
                  await editComment(widget.post_id, commentId, newText);
                  Navigator.of(context).pop();
                } else {
                  log('Edit text is empty');
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(String commentId) {
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
                await deleteComment(widget.post_id, commentId);
                Navigator.of(context).pop();
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
                    final currentUserEmail =
                        _authRepo.firebaseUser.value?.email ?? '';
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final comment = snapshot.data![index];
                        final commentEmail = comment['email'] ?? 'No email';
                        final isOwner = commentEmail == currentUserEmail;

                        return Comments(
                          text:
                              comment['commentDescription'] ?? 'No description',
                          email: commentEmail,
                          time: formatData(comment['Timestamp']),
                          comment_id: comment['comment_id'] ?? 'No ID',
                          isOwner: isOwner,
                          onEdit: isOwner
                              ? () => showEditDialog(comment['comment_id'],
                                  comment['commentDescription'])
                              : () {},
                          onDelete: isOwner
                              ? () => showDeleteConfirmationDialog(
                                  comment['comment_id'])
                              : () {},
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Add your comment!',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final commentText = textController.text;
                      final userEmail = _authRepo.firebaseUser.value?.email;

                      if (commentText.isEmpty || userEmail == null) {
                        log('Comment text or user email is empty');
                        return;
                      }

                      log(commentText);
                      log(userEmail);
                      log(DateTime.now().toString());

                      await controller1.addacomment(
                        commentModel(
                          commentDescription: commentText,
                          email: userEmail,
                          comment_id: randomAlphaNumeric(20),
                          time: DateTime.now(),
                          post_id: widget.post_id,
                        ),
                      );

                      setState(() {});
                      textController.clear();
                    },
                    icon: const Icon(Icons.arrow_upward),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
