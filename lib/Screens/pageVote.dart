import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/postController.dart';
import 'package:notify_ju/Models/postModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Screens/The_wall.dart';
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
  void setState(VoidCallback fn) {
    // TODO: implement setState
    TextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Voting'),
          backgroundColor: const Color.fromARGB(255, 195, 235, 197),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: Stream.fromFuture(controller.getpost()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data![index];

                          return wallpost(
                            description: post['description'],
                            email: post['email'],
                            post_id: post['post_id'],
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
                            hintText: 'Enter your vote',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          log(TextController.text);
                          log(_authRepo.firebaseUser.value!.email!);
                          log(DateTime.now().toString());
                          controller.addPost(
                            postModel(
                              post_id: randomAlphaNumeric(20),
                              description: TextController.text,
                              email: _authRepo.firebaseUser.value!.email!,
                              time: DateTime.now(),
                              likesCount: [],
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_upward)),
                  ],
                ),
              ),
              Text("logged in as ${_authRepo.firebaseUser.value!.email}"),
            ],
          ),
        ));
  }
}
