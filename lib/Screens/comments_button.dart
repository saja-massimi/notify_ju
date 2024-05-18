import 'package:flutter/material.dart';

class CommentsButton extends StatelessWidget {
  void Function()? onTap;
  CommentsButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.comment,
        color: Colors.grey,
      ),
    );
  }
}
