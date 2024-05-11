import 'package:flutter/material.dart';
import 'package:notify_ju/Controller/postController.dart';
import 'package:notify_ju/Models/postModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Screens/likes.dart';

class wallpost extends StatefulWidget {
  final String description;
  final String email;
  final String post_id;
  final List<String> likesCount;
  // final String time;
  const wallpost({
    super.key,
    required this.description,
    required this.email,
    required this.post_id,
    required this.likesCount,
    // required this.time,
  });

  @override
  State<wallpost> createState() => _wallpostState();
}

class _wallpostState extends State<wallpost> {
  final _authRepo = Get.put(AuthenticationRepository());
  final controller = Get.put(PostController());
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likesCount.contains(_authRepo.firebaseUser.value!.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    if (isLiked) {
      controller.likePost(postModel(
        post_id: widget.post_id,
        description: widget.description,
        email: widget.email,
      ));
    } else {
      controller.dislike(postModel(
        post_id: widget.post_id,
        description: widget.description,
        email: widget.email,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(
        top: 25,
        left: 25,
        right: 25,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            children: [Likes(isLiked: isLiked, onTap: toggleLike)],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.email,
                style: TextStyle(color: Colors.black26),
              ),
              const SizedBox(height: 10),
              Text(widget.description),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
