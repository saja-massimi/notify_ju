import 'package:flutter/material.dart';

class CommentsButton extends StatelessWidget {
  final void Function()? onTap;
  const CommentsButton({
    super.key,
    this.onTap,
  });
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
