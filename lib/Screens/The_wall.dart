import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notify_ju/Screens/like_button.dart';

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
  final currentUSer = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              LikeButton(isLiked: true, onTap: () {}),
            ],
          ),
          Text(
            widget.email,
            style: TextStyle(color: Colors.black26),
          ),
          Text(widget.description),
        ],
      ),
    );
  }
}
