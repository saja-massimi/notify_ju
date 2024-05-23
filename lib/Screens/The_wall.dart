import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/postController.dart';
import 'package:notify_ju/Models/postModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Screens/commentCard.dart';
import 'package:notify_ju/Screens/comments_button.dart';
import 'package:notify_ju/Screens/likes.dart';

class wallPost extends StatefulWidget {
  final String description;
  final String email;
  final String postId;
  final List<String> likesCount;

  const wallPost({
    Key? key,
    required this.description,
    required this.email,
    required this.postId,
    required this.likesCount,
  }) : super(key: key);

  @override
  State<wallPost> createState() => _WallPostState();
}

class _WallPostState extends State<wallPost> {
  final _authRepo = Get.put(AuthenticationRepository());
  final _postController = Get.put(PostController());
  bool isLiked = false;

  @override
  void initState() {
    super.initState();    
    isLiked = widget.likesCount.contains(_authRepo.firebaseUser.value!.email);
  }

  void toggleLike() async {
    final userEmail = _authRepo.firebaseUser.value!.email!;
    postModel model = postModel(
      post_id: widget.postId,
      description: widget.description,
      email: widget.email,
    );



    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        widget.likesCount.add(userEmail);
      } else {
        widget.likesCount.remove(userEmail);
      }
    });

    try {
      if (isLiked) {
        await _postController.likePost(model, userEmail);
      } else {
        await _postController.dislike(model, userEmail);
      }
    } catch (error) {
      print('Error toggling like: $error');
      setState(() {
        if (isLiked) {
          widget.likesCount.remove(userEmail);
        } else {
          widget.likesCount.add(userEmail);
        }
        isLiked = !isLiked;
      });
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
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
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
                child: Text(
                  widget.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.black),
                ),
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
                  Text(
                    widget.likesCount.length.toString(),
                    style: const TextStyle(color: Colors.black26),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  CommentsButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentCard(
                            post_id: widget.postId,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Comments',
                    style: TextStyle(color: Colors.black26),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
