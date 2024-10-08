import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/postController.dart';
import 'package:notify_ju/Models/postModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Screens/PagesVote/The_wall.dart';
import 'package:notify_ju/Widgets/bottomNavBar.dart';
import 'package:notify_ju/Widgets/drawer.dart';
import 'package:random_string/random_string.dart';

class VotingPage1 extends StatefulWidget {
  const VotingPage1({super.key});

  @override
  State<VotingPage1> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage1> {
  final controller = Get.put(PostController());
  final _authRepo = Get.put(AuthenticationRepository());
  final TextController = TextEditingController();

  @override
  void dispose() {
    TextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text('Posts', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF464A5E),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: Stream.fromFuture(controller.getPost()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No posts yet'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data![index];

                        return wallPost(
                          description: post['description'],
                          email: post['email'],
                          postId: post['post_id'],
                          likesCount:
                              List<String>.from(post['likesCount'] ?? []),
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
                      controller: TextController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Tell us your thoughts!',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (TextController.text.trim().isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Post cannot be empty',
                          snackPosition: SnackPosition.TOP,
                        );
                        return;
                      }

                      log(TextController.text);
                      log(_authRepo.firebaseUser.value!.email!);
                      log(DateTime.now().toString());

                      await controller.addPost(
                        postModel(
                          post_id: randomAlphaNumeric(20),
                          description: TextController.text.trim(),
                          email: _authRepo.firebaseUser.value!.email!,
                          time: DateTime.now(),
                          likesCount: [],
                        ),
                      );
                      setState(() {});
                      TextController.clear();
                    },
                    icon: const Icon(Icons.arrow_upward),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
