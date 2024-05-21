import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/postController.dart';
import 'package:notify_ju/Models/postModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Screens/commentCard.dart';
import 'package:notify_ju/Screens/comments_button.dart';
import 'package:notify_ju/Screens/likes.dart';
import 'package:notify_ju/Controller/commentController.dart';

class wallpost extends StatefulWidget {
  final String description;
  final String email;
  final String postId;
  final List<String> likesCount;
  const wallpost({
    Key? key,
    required this.description,
    required this.email,
    required this.postId,
    required this.likesCount,
  }) : super(key: key);

  @override
  State<wallpost> createState() => _wallpostState();
}

class _wallpostState extends State<wallpost> {
  final _authRepo = Get.put(AuthenticationRepository());
  final controller = Get.put(PostController());
  bool isLiked = false;
  final CommController = Get.put(commentController());

  void toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    postModel model = postModel(
      post_id: widget.postId,
      description: widget.description,
      email: widget.email,
    );

    try {
      if (isLiked) {
        await controller.likePost(model);
        print('Called likePost');
      } else {
        await controller.dislike(model);
        print('Called dislike');
      }

      setState(() {
        if (isLiked) {
          widget.likesCount.add(_authRepo.firebaseUser.value!.email!);
        } else {
          widget.likesCount.remove(_authRepo.firebaseUser.value!.email!);
        }
      });
    } catch (error) {
      print('Error toggling like: $error');
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.email,
                style: const TextStyle(color: Colors.black26),
              ),
              const SizedBox(height: 10),
              Container(
                width: 250,
                height: 60,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Text(widget.description,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Likes(isLiked: isLiked, onTap: toggleLike),
                  const SizedBox(height: 10),
                  Text(widget.likesCount.length.toString(),
                      style: const TextStyle(color: Colors.black26)),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  CommentsButton(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentCard(
                          post_id: widget.postId,
                        ),
                      ),
                    );
                  }),
                  const Text('', style: TextStyle(color: Colors.black26)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
