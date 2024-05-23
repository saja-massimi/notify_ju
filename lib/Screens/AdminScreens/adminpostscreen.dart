import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/AdminController.dart';
import 'package:notify_ju/Widgets/AdminNavBar.dart';

class AdminPostsScreen extends StatefulWidget {
  @override
  State<AdminPostsScreen> createState() => _AdminPostsScreenState();
}

class _AdminPostsScreenState extends State<AdminPostsScreen> {
  final _adminController = Get.put(AdminController());

  Future<void> deletePost1(String postId) async {
    await _adminController.deletePost(postId);
    setState(() {});
  }

  void showDeleteConfirmationDialog(String postId) {
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
                await deletePost1(postId);
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
        title: const Text('All Users Posts',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF464A5E),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Stream.fromFuture(_adminController.getPost()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  title: Text(post['description']),
                  subtitle: Text(
                      'By: ${post['email']}\nLikes: ${post['likesCount']?.length.toString()}'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => showDeleteConfirmationDialog(
                        post['post_id'] ?? '',
                      ),
                    ),
                  ]),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: AdminNavigationBarWidget(),
    );
  }
}
