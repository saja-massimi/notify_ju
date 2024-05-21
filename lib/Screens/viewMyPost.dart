import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/postController.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';

class ViewMyPost extends StatefulWidget {
  final String? post_id;

  const ViewMyPost({
    super.key,
    this.post_id,
  });

  @override
  _ViewMyPostState createState() => _ViewMyPostState();
}

class _ViewMyPostState extends State<ViewMyPost> {
  final controller = Get.put(PostController());
  final TextEditingController textController = TextEditingController();
  Future<void> deletePost(String post_id) async {
    await controller.deletePost(post_id);
    setState(() {});
  }

  Future<void> editPost(String post_id, String newText) async {
    await controller.updatePost(post_id, newText);
    setState(() {});
  }

  void showEditDialog(String post_id, String currentText) {
    textController.text = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Post'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Edit your Post'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await editPost(post_id, textController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(String post_id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Post'),
          content: const Text('Are you sure you want to delete this Post?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await deletePost(post_id);
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
      appBar: AppBar(
        title: Text('My Posts', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF464A5E),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: controller.viewAllUserPosts(), // Fetch user posts
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            log("Error fetching user posts: ${snapshot.error}");
            return const Center(
              child: Text('Error fetching user posts'),
            );
          } else if (snapshot.hasData) {
            final List<Map<String, dynamic>> posts = snapshot.data!;

            if (posts.isEmpty) {
              return const Center(
                child: Text('No posts found'),
              );
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post['description'] ?? 'No Title'),
                  subtitle: Text(post['email'] ?? 'No Content'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => showEditDialog(
                          post['post_id'] ?? '',
                          post['description'] ?? '',
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => showDeleteConfirmationDialog(
                          post['post_id'] ?? '',
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data found'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
